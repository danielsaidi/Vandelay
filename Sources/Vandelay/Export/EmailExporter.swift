//
//  EmailExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-05.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

#if !os(macOS)
import MessageUI

/**
 This exporter can export string and data files by attaching
 them to emails.
 
 Since this exporter requires a view controller from which a
 mail composer is presented, you must create the exporter by
 passing in the view controller that triggers the export.
 
 Since this exporter requires a source view controller, from
 which the e-mail composer is presented, you must create the
 exporter from the view controller that triggers the export.
 
 Use the `fileName` initializer if the exported files should
 have the same name at all times. Use the `fileNameGenerator`
 initializer if you require dynamic file names.
 
 Note that there is no corresponding "e-mail importer". This
 is because you instead must link the app with the file type
 you use, then read and import the data that is sent to your
 app when a user taps the file on her/his device.
 
 IMPORTANT: Since the exporter waits for user input, it must
 be strongly referenced, to avoid deallocation. It must also
 inherit from `NSObject`, since it implements protocols that
 require it to.
 */
public class EmailExporter: DataExporter, StringExporter {

    
    // MARK: - Initialization
    
    public convenience init(fromViewController: UIViewController, fileName: String, emailSubject: String? = nil, emailBody: String? = nil) {
        let generator = StaticFileNameGenerator(fileName: fileName)
        self.init(fromViewController: fromViewController, fileNameGenerator: generator, emailSubject: emailSubject, emailBody: emailBody)
    }
    
    public init(fromViewController: UIViewController, fileNameGenerator: FileNameGenerator, emailSubject: String? = nil, emailBody: String? = nil) {
        self.fromViewController = fromViewController
        self.fileNameGenerator = fileNameGenerator
        self.emailSubject = emailSubject
        self.emailBody = emailBody
    }
    
    
    // MARK: - ComposerDelegate
    
    private class ComposerDelegate: NSObject, MFMailComposeViewControllerDelegate {
        
        init(exporter: EmailExporter) {
            self.exporter = exporter
        }
        
        var exporter: EmailExporter
        
        public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
            let result = ExportResult(method: exporter.exportMethod, state: result.exportState, error: error)
            exporter.completion?(result)
            ComposerDelegate.current = nil
        }
    
        static var current: ComposerDelegate?
    }
    
    
    // MARK: - Dependencies
    
    private let fileNameGenerator: FileNameGenerator
    private weak var fromViewController: UIViewController?
    
    
    // MARK: - Properties
    
    public let exportMethod = ExportMethod.email
    
    private var completion: ExportCompletion!
    private let emailBody: String?
    private let emailSubject: String?
    
    
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
        openEmailComposer(from: vc, data: data)
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

private extension EmailExporter {
    
    func openEmailComposer(from vc: UIViewController, data: Data) {
        let composer = MFMailComposeViewController()
        let delegate = ComposerDelegate(exporter: self)
        ComposerDelegate.current = delegate
        composer.mailComposeDelegate = delegate
        if let subject = emailSubject { composer.setSubject(subject) }
        if let body = emailBody { composer.setMessageBody(body, isHTML: true) }
        composer.addAttachmentData(data, mimeType: "text/plain", fileName: fileNameGenerator.getFileName())
        vc.present(composer, animated: true, completion: nil)
    }
}


// MARK: - MFMailComposeResult extensions

private extension MFMailComposeResult {
    
    var exportState: ExportState {
        switch self {
        case .cancelled: return .cancelled
        case .failed: return .failed
        case .sent: return .completed
        case .saved: return .cancelled
        @unknown default: return .unknown
        }
    }
}
#endif
