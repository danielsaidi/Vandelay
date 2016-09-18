//
//  EmailExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-05.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can export strings and data to an email
 attachment.
 
 Use the fileName initializer if your file should have
 the same name at all times. Use the fileNameGenerator
 initializer if you require dynamic file names.
 
 Note that there is no corresponding email importer to
 this exporter. Instead, an app you must make your app
 handle certain file types, then detect whenever these
 kind of files are tapped, e.g. in an e-mail. When the
 file is opened by the app, read and import the data.
 
 */

import MessageUI

public class EmailExporter {/* TODO: NSObject, DataExporter, StringExporter, MFMailComposeViewControllerDelegate {
    
    
    // MARK: Initialization
    
    public convenience init(fileName: String) {
        self.init(fileNameGenerator: StaticFileNameGenerator(fileName: fileName))
    }
    
    public convenience init(fileNameGenerator: FileNameGenerator) {
        self.init()
        self.fileNameGenerator = fileNameGenerator
    }
    
    
    
    // MARK: Properties
    
    public private(set) var exportMethod = "Email"
    
    public var emailBody = ""
    public var emailSubject = ""
    public var fileNameGenerator: FileNameGenerator!
    
    private var mailComposer: MFMailComposeViewController!
    private var completion: ((_ result: ExportResult) -> ())?
    
    
    
    // MARK: Public functions
    
    public func export(data: Data, completion: ((_ result: ExportResult) -> ())?) {
        let vc = getTopmostViewController()
        if (vc == nil) {
            let error = "EmailExporter could not find topmost view controller"
            completion?(getResult(withErrorMessage: error))
            return
        }
        
        sendData(data: data, fromViewController: vc!, completion: completion)
    }
    
    public func export(string: String, completion: ((_ result: ExportResult) -> ())?) {
        let data = string.data(using: .utf8)
        if (data == nil) {
            let error = "EmailExporter could not serialize string to data"
            completion?(getResult(withErrorMessage: error))
            return
        }
        
        export(data: data!, completion: completion)
    }
    
    
    
    // MARK: Private functions
    
    private func getExportStateForSendResult(sendResult: MFMailComposeResult) -> ExportState {
        switch sendResult {
        case .cancelled: return .Cancelled
        case .failed: return .Failed
        case .sent: return .Completed
        case .saved: return .Cancelled
        default: return .Failed
        }
    }
    
    private func sendData(data: Data, fromViewController vc: UIViewController, completion: ((_ result: ExportResult) -> ())?) {
        mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject(emailSubject)
        mailComposer.setMessageBody(emailBody, isHTML: true)
        mailComposer.addAttachmentData(data, mimeType: "text/plain", fileName: fileNameGenerator.getFileName())
        
        vc.present(mailComposer, animated: true, completion: nil)
        
        self.completion = completion
    }
    
    
    
    // MARK: MFMailComposeViewControllerDelegate
    
    public func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult sendResult: MFMailComposeResult, error: NSError?) {
        controller.presentingViewController?.dismiss(animated: true, completion: nil)
        let state = getExportStateForSendResult(sendResult: sendResult)
        let result = getResult(state: state)
        result.error = error
        completion?(result)
    }*/
}
