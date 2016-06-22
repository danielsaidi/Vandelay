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
 
 - Create an app in the Dropbox developer portal
 - Install SwiftyDropbox, preferably with CocoaPods (see install link above)
 - Import SwiftyDropbox and call Dropbox.setupWithAppKey("...") at app launch
 - Go to the app target's Info tab and add a URL Type with URL Scheme "db-<APP KEY>"
 - Open info.plist and add LSApplicationQueriesSchemes (see tutorial link above)
 
 Finally Dropbox requires that the user authorizes the
 app to be used with Dropbox. Whenever an app requires
 this authorization to be made, Dropbox will open in a
 separate app or browser, ask for permission, then pop
 back to the app.
 
 For this to work, the app must handle the Dropbox url
 in the AppDelegate class. Have a look at how the demo
 app handles this.
 
 If you do not handle this callback url, your app will
 never be authorized, and will just keep on asking for
 permission.
 
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
    
    public func exportData(data: NSData, completion: ((result: ExportResult) -> ())?) {
        let vc = getTopmostViewController()
        if (vc == nil) {
            let error = "DropboxExporter could not find topmost view controller"
            completion?(result: getResultWithErrorMessage(error))
            return
        }
        
        if (willAuthorizeFromViewController(vc!)) {
            completion?(result: ExportResult(state: .Cancelled))
            return
        }
        
        uploadData(data, completion: completion)
    }
    
    public func exportString(string: String, completion: ((result: ExportResult) -> ())?) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        if (data == nil) {
            let error = "DropboxExporter could not create data from string"
            completion?(result: getResultWithErrorMessage(error))
            return
        }
        
        exportData(data!, completion: completion)
    }
    
    
    
    // MARK: Private functions
    
    private func uploadData(data: NSData, completion: ((result: ExportResult) -> ())?) {
        let client = DropboxClient.sharedClient!
        let fileName = fileNameGenerator.getFileName()
        let path = "/\(fileName)"
        
        let inProgressResult = ExportResult(state: .InProgress)
        inProgressResult.filePath = fileName
        completion?(result: inProgressResult)
        
        client.files.upload(path: path, mode: .Overwrite, mute: true, body: data).response {
            response, error in
            if (error == nil && response != nil) {
                completion?(result: self.getResultWithFilePath(fileName))
            } else {
                let message = error!.description
                completion?(result: self.getResultWithErrorMessage(message))
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
