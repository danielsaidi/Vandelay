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

public class EmailExporter: NSObject, DataExporter, StringExporter {
    
    
    // MARK: - Initialization
    
    public convenience init(fileName: String) {
        let generator = StaticFileNameGenerator(fileName: fileName)
        self.init(fileNameGenerator: generator)
    }
    
    public init(fileNameGenerator: FileNameGenerator) {
        self.fileNameGenerator = fileNameGenerator
        super.init()
    }
    
    
    
    // MARK: - Dependencies
    
    public var fileNameGenerator: FileNameGenerator
    
    
    
    // MARK: - Properties
    
    public private(set) var exportMethod = "Email"
    
    public var emailBody = ""
    public var emailSubject = ""
    
    public var errorMessageForFailedSerialization = "EmailExporter could not serialize string to data"
    public var errorMessageForMissingTopmostViewController = "EmailExporter could not find topmost view controller"
    
    fileprivate var completion: ((_ result: ExportResult) -> ())?
    private var composer: MFMailComposeViewController!
    
    
    
    // MARK: - Public functions
    
    public func export(data: Data, completion: ExportCompletion?) {
        guard let vc = topmostViewController else {
            let error = errorMessageForMissingTopmostViewController
            completion?(getResult(withErrorMessage: error))
            return
        }
        send(data, from: vc, completion: completion)
    }
    
    public func export(string: String, completion: ExportCompletion?) {
        guard let data = string.data(using: .utf8) else {
            let error = errorMessageForFailedSerialization
            completion?(getResult(withErrorMessage: error))
            return
        }
        export(data: data, completion: completion)
    }
    
    
    
    // MARK: - Private functions
    
    fileprivate func getExportState(for sendResult: MFMailComposeResult) -> ExportState {
        switch sendResult {
        case .cancelled: return .cancelled
        case .failed: return .failed
        case .sent: return .completed
        case .saved: return .cancelled
        }
    }
    
    private func send(_ data: Data, from vc: UIViewController, completion: ExportCompletion?) {
        composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setSubject(emailSubject)
        composer.setMessageBody(emailBody, isHTML: true)
        composer.addAttachmentData(data, mimeType: "text/plain", fileName: fileNameGenerator.getFileName())
        
        vc.present(composer, animated: true, completion: nil)
        
        self.completion = completion
    }
}



// MARK: - MFMailComposeViewControllerDelegate

extension EmailExporter: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.presentingViewController?.dismiss(animated: true, completion: nil)
        let state = getExportState(for: result)
        let result = getResult(withState: state)
        result.error = error != nil ? getError(withErrorMessage: error!.localizedDescription) : nil
        completion?(result)
    }
}
