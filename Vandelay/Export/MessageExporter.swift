//
//  MessageExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-05.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can export string and data files by attaching
 them to messages.
 
 Since this exporter requires a source view controller, from
 which the message composer is presented, you must create it
 from the view controller that triggers the export.
 
 Use the `fileName` initializer if the exported files should
 have the same name at all times. Use the `fileNameGenerator`
 initializer if you require dynamic file names.
 
 Note that there is no corresponding "message importer". You
 must instead link your app with the file type you use, then
 read and import the data that is sent to the app when users
 tap the file on their devices.
 
 IMPORTANT: Since this exporter opens a message compose view
 controller, you must keep a strong reference to it to avoid
 that it is deallocated while you complete the export.
 
 */

import MessageUI

public class MessageExporter: NSObject, DataExporter, StringExporter {
    
    
    // MARK: - Initialization
    
    public convenience init(fromViewController: UIViewController?, fileName: String, messageSubject: String? = nil, messageBody: String? = nil) {
        let generator = StaticFileNameGenerator(fileName: fileName)
        self.init(fromViewController: fromViewController, fileNameGenerator: generator, messageSubject: messageSubject, messageBody: messageBody)
    }
    
    public init(fromViewController: UIViewController?, fileNameGenerator: FileNameGenerator, messageSubject: String? = nil, messageBody: String? = nil) {
        self.fromViewController = fromViewController
        self.fileNameGenerator = fileNameGenerator
        self.messageSubject = messageSubject
        self.messageBody = messageBody
        super.init()
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
        self.composer = composer
        composer.messageComposeDelegate = self
        composer.subject = messageSubject
        composer.body = messageBody
        composer.addAttachmentData(data, typeIdentifier: "public.data", filename: fileNameGenerator.getFileName())
        vc.present(composer, animated: true, completion: nil)
    }
}


// MARK: - MFMailComposeViewControllerDelegate

extension MessageExporter: MFMessageComposeViewControllerDelegate {
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.presentingViewController?.dismiss(animated: true, completion: nil)
        let result = ExportResult(method: exportMethod, state: result.exportState)
        completion(result)
    }
}


// MARK: - Private functions

private extension MessageComposeResult {
    
    var exportState: ExportState {
        switch self {
        case .cancelled: return .cancelled
        case .failed: return .failed
        case .sent: return .completed
        }
    }
}
