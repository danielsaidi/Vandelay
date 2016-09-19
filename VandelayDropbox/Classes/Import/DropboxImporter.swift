//
//  DropboxImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-03.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This importer can be used to import strings and large
 data blobs from Dropbox.
 
 Since Dropbox imports are async, you will receive two
 callbacks; one to tell you that the import begun, and
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

public class DropboxImporter: NSObject, DataImporter, StringImporter {
    
    
    // MARK: Initialization
    
    public convenience init(fileName: String) {
        self.init(fileNameGenerator: StaticFileNameGenerator(fileName: fileName))
    }
    
    public init(fileNameGenerator: FileNameGenerator) {
        self.fileNameGenerator = fileNameGenerator
        super.init()
    }
    
    
    
    // MARK: Properties
    
    public private(set) var importMethod = "Dropbox"
    
    public var errorMessageForDownloadError = "DropboxExporter could not create data from string"
    public var errorMessageForFileError = "DropboxExporter could not create data from string"
    public var errorMessageForStringError = "DropboxExporter could not create data from string"
    public var errorMessageForViewController = "DropboxExporter could not find topmost view controller"
    
    private var fileNameGenerator: FileNameGenerator
    
    
    
    // MARK: Public functions
    
    public func importData(completion: ((_ result: ImportResult) -> ())?) {
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
        
        downloadData(withClient: client, completion: completion)
    }
    
    public func importString(completion: ((_ result: ImportResult) -> ())?) {
        importData { (result) in
            if (result.data != nil) {
                if let string = String(data: result.data!, encoding: .utf8) {
                    completion?(self.getResult(withString: string))
                } else {
                    completion?(self.getResult(withErrorMessage: "Dropbox file did not contain valid content."))
                }
            } else {
                completion?(result)
            }
        }
    }
    
    
    
    // MARK: Private functions
    
    private func downloadData(withClient client: DropboxClient, completion: ((_ result: ImportResult) -> ())?) {
        let fileName = fileNameGenerator.getFileName()
        let filePath = "/\(fileName)"
        
        completion?(ImportResult(state: .inProgress))
        
        let destination = getDownloadDestination()
        
        let _ = client.files .download(path: filePath, destination: destination).response { response, error in
            guard let (_, url) = response else {
                let errorMessage = error?.description ?? self.errorMessageForDownloadError
                completion?(self.getResult(withErrorMessage: errorMessage))
                return
            }
        
            do {
                let data = try Data(contentsOf: url)
                completion?(self.getResult(withData: data))
            } catch {
                completion?(self.getResult(withErrorMessage: self.errorMessageForFileError))
            }
        }
    }
    
    private func getDownloadDestination() -> ((URL, HTTPURLResponse) -> URL) {
        return { temporaryURL, response in
            let fileManager = FileManager.default
            let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let pathComponent = "\(NSUUID().uuidString)-\(response.suggestedFilename!)"
            return directoryURL.appendingPathComponent(pathComponent)
        }
    }
}
