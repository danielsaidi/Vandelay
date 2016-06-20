//
//  EmailExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-05.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can be used to send strings and data as
 e-mail attachments.
 
 Use the fileName initializer if your file should have
 the same name at all times. Use the fileNameGenerator
 initializer if you require dynamic file names.
 
 */


import MessageUI

public class EmailExporter: NSObject, DataExporter, StringExporter, MFMailComposeViewControllerDelegate {
    
    
    // MARK: Initialization
    
    public convenience init(fileName: String) {
        self.init(fileNameGenerator: StaticFileNameGenerator(fileName: fileName))
    }
    
    public convenience init(fileNameGenerator: FileNameGenerator) {
        self.init()
        self.fileNameGenerator = fileNameGenerator
    }
    
    
    
    // MARK: Properties
    
    public var exportMethod: String? { return "Email" }
    
    public var emailBody = ""
    public var emailSubject = ""
    public var fileNameGenerator: FileNameGenerator!
    
    private var mailComposer: MFMailComposeViewController!
    private var completion: ((result: ExportResult) -> ())!
    
    
    
    // MARK: Public functions
    
    public func exportData(data: NSData, completion: ((result: ExportResult) -> ())) {
        let vc = getTopmostViewController()
        if (vc == nil) {
            completion(result: getResultWithErrorMessage("EmailExporter could not find topmost view controller"))
            return
        }
        
        sendData(data, fromViewController: vc!, completion: completion)
    }
    
    public func exportString(string: String, completion: ((result: ExportResult) -> ())) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding)
        if (data == nil) {
            completion(result: getResultWithErrorMessage("EmailExporter could not serialize string to data"))
            return
        }
        
        exportData(data!, completion: completion)
    }
    
    
    
    // MARK: Private functions
    
    private func getExportStateForSendResult(sendResult: MFMailComposeResult) -> ExportState {
        switch sendResult {
        case MFMailComposeResultCancelled: return .Cancelled
        case MFMailComposeResultFailed: return .Failed
        case MFMailComposeResultSent: return .Completed
        case MFMailComposeResultSaved: return .Cancelled
        default: return .Failed
        }
    }
    
    private func sendData(data: NSData, fromViewController vc: UIViewController, completion: ((result: ExportResult) -> ())) {
        mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject(emailSubject)
        mailComposer.setMessageBody(emailBody, isHTML: true)
        mailComposer.addAttachmentData(data, mimeType: "text/plain", fileName: fileNameGenerator.getFileName())
        
        vc.presentViewController(mailComposer, animated: true, completion: nil)
        
        self.completion = completion
    }
    
    
    
    // MARK: MFMailComposeViewControllerDelegate
    
    public func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult sendResult: MFMailComposeResult, error: NSError?) {
        controller.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        let result = ExportResult(state: getExportStateForSendResult(sendResult))
        result.error = error
        completion?(result: result)
    }
}