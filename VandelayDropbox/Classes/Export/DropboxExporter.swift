//
//  DropboxDataExporterDefault.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-03.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 When using this exporter, make sure that Dropbox have
 been properly setup for your app, as specified in the
 Dropbox iOS docs. Dropbox.setupWithAppKey(..) must be
 called when the app is started. Also make sure to add
 CFBundleURLTypes and LSApplicationQueriesSchemes into
 the Info.plist file.
 
 The file name generator that you must provide, can be
 any of the file name generators that are available in
 Vandelay, or any custom generator you like. Just make
 sure to use a non-random generator if you plan to use
 the file for syncing data across devices.
 
 */


import Foundation
import SwiftyDropbox
import Vandelay

public class DropboxExporter : NSObject, DataExporter, StringExporter {
    
    
    // MARK: Initialization
    
    public init(fileNameGenerator: FileNameGenerator) {
        self.fileNameGenerator = fileNameGenerator
        super.init()
    }
    
    
    
    // MARK: Properties
    
    public var context: String? { return "Dropbox" }
    
    private var fileNameGenerator: FileNameGenerator
    
    
    
    // MARK: Public functions
    
    public func exportData(data: NSData, completion: ((result: ExportResult) -> ())) {
        let vc = getTopmostViewController()
        if (vc == nil) {
            completion(result: getResultWithErrorMessage("DropboxExporter could not find topmost view controller"))
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
            completion(result: getResultWithErrorMessage("DropboxExporter could not create data from string"))
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
