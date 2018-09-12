//
//  EmailExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-05.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 IMPORTANT: Since this exporter opens an e-mail compose view
 controller, you must keep a strong reference to it to avoid
 that it is deallocated while you complete the export.
 
 This exporter can export string and data files by attaching
 them to emails.
 
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
 
 */

import MessageUI

public class EmailExporter: NSObject, DataExporter, StringExporter {

    
    // MARK: - Initialization
    
    public convenience init(fromViewController: UIViewController?, fileName: String, emailSubject: String? = nil, emailBody: String? = nil) {
        let generator = StaticFileNameGenerator(fileName: fileName)
        self.init(fromViewController: fromViewController, fileNameGenerator: generator, emailSubject: emailSubject, emailBody: emailBody)
    }
    
    public init(fromViewController: UIViewController?, fileNameGenerator: FileNameGenerator, emailSubject: String? = nil, emailBody: String? = nil) {
        self.fromViewController = fromViewController
        self.fileNameGenerator = fileNameGenerator
        self.emailSubject = emailSubject
        self.emailBody = emailBody
        super.init()
    }
    
    
    // MARK: - Dependencies
    
    private let fileNameGenerator: FileNameGenerator
    private weak var fromViewController: UIViewController?
    
    
    // MARK: - Properties
    
    public let exportMethod = ExportMethod.email
    
    private var completion: ExportCompletion!
    private var composer: MFMailComposeViewController?
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
        self.composer = composer
        composer.mailComposeDelegate = self
        if let subject = emailSubject { composer.setSubject(subject) }
        if let body = emailBody { composer.setMessageBody(body, isHTML: true) }
        composer.addAttachmentData(data, mimeType: "text/plain", fileName: fileNameGenerator.getFileName())
        vc.present(composer, animated: true, completion: nil)
    }
}


// MARK: - MFMailComposeViewControllerDelegate

extension EmailExporter: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.presentingViewController?.dismiss(animated: true, completion: nil)
        let result = ExportResult(method: exportMethod, state: result.exportState, error: error)
        completion?(result)
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
        }
    }
}
