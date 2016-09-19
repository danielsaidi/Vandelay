//
//  DropboxExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-03.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can be used to export strings and large
 data blobs to Dropbox.
 
 Since Dropbox exports are async, you will receive two
 callbacks; one to tell you that the export begun, and
 one to tell you if it succeeded or failed.
 
 Use the fileName initializer if your file should have
 the same name at all times. Use the fileNameGenerator
 initializer if you require dynamic file names.
 
 */

/*
 
 Instructions:
 
 When using this exporter, make sure that Dropbox have
 been properly setup, as specified in the docs:
 
 https://www.dropbox.com/developers/documentation/swift#overview
 https://www.dropbox.com/developers/documentation/swift#install
 https://www.dropbox.com/developers/documentation/swift#tutorial
 
 In short, these documents tell you that you should:
 
 - Create an app in the Dropbox developer portal
 - Install SwiftyDropbox, preferably with CocoaPods
 - Import SwiftyDropbox and call Dropbox.setupWithAppKey("...") at app launch
 - Go to the app target's Info tab and add a URL Type with URL Scheme "db-<APP KEY>"
 - Open info.plist and add the LSApplicationQueriesSchemes from the tutorial
 - In the app, then ask the user for permission to let Dropbox be used in the app
 - Handle the callback url that is received once the user has approved or denied permission
 
 SwiftyDropbox is automatically added to projects that
 installs VandelayDropbox with CocoaPods.
 
 If you do not handle the callback, the app will never
 be authorized and will keep asking for the permission
 everytime the Dropbox exporter or importer is used.
 
 */


import Foundation
import SwiftyDropbox
import Vandelay

public class DropboxExporter: NSObject, DataExporter, StringExporter {
    
    
    // MARK: Initialization
    
    public convenience init(fileName: String) {
        self.init(fileNameGenerator: StaticFileNameGenerator(fileName: fileName))
    }
    
    public init(fileNameGenerator: FileNameGenerator) {
        self.fileNameGenerator = fileNameGenerator
        super.init()
    }
    
    
    
    // MARK: Properties
    
    public private(set) var exportMethod = "Dropbox"
    
    public var errorMessageForViewController = "DropboxExporter could not find topmost view controller"
    public var errorMessageForDataError = "DropboxExporter could not create data from string"
    
    private var fileNameGenerator: FileNameGenerator
    
    
    
    // MARK: Public functions
    
    public func exportData(_ data: Data, completion: ((_ result: ExportResult) -> ())?) {
        guard let vc = topmostViewController else {
            completion?(getResult(withErrorMessage: errorMessageForViewController))
            return
        }
        
        guard let client = DropboxClientsManager.authorizedClient else {
            let app = UIApplication.shared
            DropboxClientsManager.authorizeFromController(app, controller: vc, openURL: { url in
                app.openURL(url)
            })
            completion?(getResult(withState: .cancelled))
            return
        }
        
        uploadData(data, withClient: client, completion: completion)
    }
    
    public func exportString(_ string: String, completion: ((_ result: ExportResult) -> ())?) {
        guard let data = string.data(using: .utf8, allowLossyConversion: false) else {
            completion?(getResult(withErrorMessage: errorMessageForDataError))
            return
        }
        
        exportData(data, completion: completion)
    }
    
    
    
    // MARK: Private functions
    
    private func uploadData(_ data: Data, withClient client: DropboxClient, completion: ((_ result: ExportResult) -> ())?) {
        let fileName = fileNameGenerator.getFileName()
        let path = "/\(fileName)"
        
        let inProgressResult = getResult(withState: .inProgress)
        inProgressResult.filePath = fileName
        completion?(inProgressResult)
        
        let _ = client.files.upload(path: path, mode: .overwrite, autorename: true, clientModified: nil, mute: true, input: data).response { (metadata, error) in
            if (error == nil && metadata != nil) {
                completion?(self.getResult(withFilePath: fileName))
            } else {
                let message = error!.description
                completion?(self.getResult(withErrorMessage: message))
            }
        }
    }
}
