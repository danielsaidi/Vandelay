//
//  DropboxDataExporterDefault.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-03.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can be used to export strings and large
 data blobs. Since Dropbox exports are async, you will
 receive two callbacks for successful exports - one to
 tell you that the export begun and one to tell you if
 the export succeeded or failed.
 
 When using this exporter, make sure that Dropbox have
 been properly setup, as specified in the docs:
 
 - Create an app in the Dropbox developer portal
 - Call Dropbox.setupWithAppKey(..) when the app is started
 - Add CFBundleURLTypes to Info.plist
 - Add LSApplicationQueriesSchemes to Info.plist
 
 Use the fileName initializer if your file should have
 the same name at all times. Use the fileNameGenerator
 initializer if you require dynamic file names.
 
 */


import Foundation
import SwiftyDropbox
import Vandelay

public class DropboxExporter : NSObject, DataExporter, StringExporter {
    
    
    // MARK: Initialization
    
    public convenience init(fileName: String) {
        self.init(fileNameGenerator: StaticFileNameGenerator(fileName: fileName))
    }
    
    public init(fileNameGenerator: FileNameGenerator) {
        self.fileNameGenerator = fileNameGenerator
        super.init()
    }
    
    
    
    // MARK: Properties
    
    public var exportMethod: String? { return "Dropbox" }
    
    private var fileNameGenerator: FileNameGenerator
    
    
    
    // MARK: Public functions
    
    public func exportData(data: NSData, completion: ((result: ExportResult) -> ())) {
        let vc = getTopmostViewController()
        if (vc == nil) {
            let error = "DropboxExporter could not find topmost view controller"
            completion(result: getResultWithErrorMessage(error))
            return
        }
        
        if (willAuthorizeFromViewController(vc!)) {
            completion(result: ExportResult(state: .Cancelled))
            return
        }
        
        uploadData(data, completion: completion)
    }
    
    public func exportString(string: String, completion: ((result: ExportResult) -> ())) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        if (data == nil) {
            let error = "DropboxExporter could not create data from string"
            completion(result: getResultWithErrorMessage(error))
            return
        }
        
        exportData(data!, completion: completion)
    }
    
    
    
    // MARK: Private functions
    
    private func uploadData(data: NSData, completion: ((result: ExportResult) -> ())) {
        let client = DropboxClient.sharedClient!
        let fileName = fileNameGenerator.getFileName()
        let path = "/\(fileName)"
        
        let inProgressResult = ExportResult(state: .InProgress)
        inProgressResult.filePath = fileName
        completion(result: inProgressResult)
        
        client.files.upload(path: path, mode: .Overwrite, mute: true, body: data).response {
            response, error in
            if (error == nil && response != nil) {
                completion(result: self.getResultWithFilePath(fileName))
            } else {
                let message = error!.description
                completion(result: self.getResultWithErrorMessage(message))
            }
        }
    }
    
    private func willAuthorizeFromViewController(vc: UIViewController) -> Bool {
        let client = Dropbox.authorizedClient
        if (client == nil) {
            Dropbox.authorizeFromController(vc)
            return true
        }
        return false
    }
    
}
