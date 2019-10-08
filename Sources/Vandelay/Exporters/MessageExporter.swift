//
//  MessageExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-05.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

#if !os(macOS)
import MessageUI

/**
 This exporter can export string and data files by attaching
 them to messages.
 
 Since this exporter requires a view controller from which a
 message composer is presented, you must create the exporter
 by passing in the view controller that triggers the export.
 
 Use the `fileName` initializer if the exported files should
 have the same name at all times. Use the `fileNameGenerator`
 initializer if you require dynamic file names.
 
 Note that there is no corresponding "message importer". You
 must instead link your app with the file type you use, then
 read and import the data that is sent to the app when users
 tap the file on their devices.
 */
public class MessageExporter: DataExporter, StringExporter {
    
    
    // MARK: - Initialization
    
    public convenience init(fromViewController: UIViewController, fileName: String, messageSubject: String? = nil, messageBody: String? = nil) {
        let generator = StaticFileNameGenerator(fileName: fileName)
        self.init(fromViewController: fromViewController, fileNameGenerator: generator, messageSubject: messageSubject, messageBody: messageBody)
    }
    
    public init(fromViewController: UIViewController, fileNameGenerator: FileNameGenerator, messageSubject: String? = nil, messageBody: String? = nil) {
        self.fromViewController = fromViewController
        self.fileNameGenerator = fileNameGenerator
        self.messageSubject = messageSubject
        self.messageBody = messageBody
    }
    
    
    // MARK: - Dependencies
    
    private let fileNameGenerator: FileNameGenerator
    private weak var fromViewController: UIViewController?
    
    
    // MARK: - Properties
    
    public let exportMethod = ExportMethod.message
    
    private var completion: ExportCompletion!
    private var composer: MFMessageComposeViewController?
    private let messageBody: String?
    private let messageSubject: String?
    
    
    // MARK: - ComposerDelegate
    
    private class ComposerDelegate: NSObject, MFMessageComposeViewControllerDelegate {
        
        init(exporter: MessageExporter) {
            self.exporter = exporter
        }
        
        var exporter: MessageExporter
        
        public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.presentingViewController?.dismiss(animated: true, completion: nil)
            let result = ExportResult(method: exporter.exportMethod, state: result.exportState)
            exporter.completion(result)
            ComposerDelegate.current = nil
        }
    
        static var current: ComposerDelegate?
    }
    
    
    // MARK: - Errors
    
    enum ExportError: Error {
        case fromViewControllerDeallocated
        case stringCouldNotBeEncoded
    }
    
    
    // MARK: - DataExporter
    
    public func export(data: Data, completion: @escaping ExportCompletion) {
        guard let vc = fromViewController else {
            let error = ExportError.fromViewControllerDeallocated
            let result = ExportResult(method: exportMethod, error: error)
            return completion(result)
        }
        self.completion = completion
        openMessageComposer(from: vc, data: data)
    }
    
    
    // MARK: - StringExporter
    
    public func export(string: String, completion: @escaping ExportCompletion) {
        guard let data = string.data(using: .utf8) else {
            let error = ExportError.stringCouldNotBeEncoded
            let result = ExportResult(method: exportMethod, error: error)
            return completion(result)
        }
        export(data: data, completion: completion)
    }
}


// MARK: - Private Functions

private extension MessageExporter {
    
    func openMessageComposer(from vc: UIViewController, data: Data) {
        let composer = MFMessageComposeViewController()
        let delegate = ComposerDelegate(exporter: self)
        ComposerDelegate.current = delegate
        composer.messageComposeDelegate = delegate
        composer.subject = messageSubject
        composer.body = messageBody
        composer.addAttachmentData(data, typeIdentifier: "public.data", filename: fileNameGenerator.getFileName())
        vc.present(composer, animated: true, completion: nil)
    }
}


// MARK: - Private functions

private extension MessageComposeResult {
    
    var exportState: ExportState {
        switch self {
        case .cancelled: return .cancelled
        case .failed: return .failed
        case .sent: return .completed
        @unknown default: return .unknown
        }
    }
}
#endif
