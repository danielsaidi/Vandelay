//
//  DropboxExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-03.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can export strings and data to Dropbox.
 
 Use the `fileName` initializer if the exported files should
 have the same name at all times. Use the `fileNameGenerator`
 initializer if you require dynamic file names.
 
 */

/*
 
 Instructions:
 
 Before using this exporter, make sure that Dropbox has been
 properly setup, as specified in the docs:
 
 https://www.dropbox.com/developers/documentation/swift
 
 In short, these documents will instruct you that you should:
 
 - Create an app in the Dropbox developer portal
 - Install SwiftyDropbox with CocoaPods or Carthage
 - Import SwiftyDropbox and call `Dropbox.setupWithAppKey("...")` at app launch
 - Go to the app target's Info tab and add a URL Type with URL Scheme "db-<APP KEY>"
 - Open `info.plist` and add the `LSApplicationQueriesSchemes` from the tutorial
 - In the app, then ask the user for permission to let Dropbox be used in the app
 - Handle the callback url that is received once the user has approved or denied permission
 
 If you use CocoaPods to add VandelayDropbox to an app, your
 app will automatically be linked with SwiftyDropbox. If you
 use Carthage, however, you must add SwiftyDropbox.framework
 to your app manually.
 
 IMPORTANT: Since the importer waits for user input, it must
 be strongly referenced to avoid deallocation.
 
 IMPORTANT: If you do not handle the exporter callback, your
 app will never be authorized, and will keep asking for this
 permission each time this exporter is used. Look at the app
 `AppDelegate.swift` to see how to handle the auth result.
 
 */


import SwiftyDropbox
import Vandelay

public class DropboxExporter: DataExporter, StringExporter, DropboxClientCreator {
    
    
    // MARK: Initialization
    
    public convenience init(fromViewController: UIViewController, fileName: String) {
        let generator = StaticFileNameGenerator(fileName: fileName)
        self.init(fromViewController: fromViewController, fileNameGenerator: generator)
    }
    
    public init(fromViewController: UIViewController, fileNameGenerator: FileNameGenerator) {
        self.fromViewController = fromViewController
        self.fileNameGenerator = fileNameGenerator
    }
    
    
    // MARK: - Dependencies
    
    private let fileNameGenerator: FileNameGenerator
    private weak var fromViewController: UIViewController?
    
    
    // MARK: Properties
    
    public let exportMethod = ExportMethod.dropbox
    
    
    // MARK: - Errors
    
    enum ExportError: Error {
        case
        fromViewControllerDeallocated,
        invalidFilePath,
        invalidString,
        uploadError(description: String)
    }
    
    
    // MARK: Public functions
    
    public func export(data: Data, completion: @escaping ExportCompletion) {
        if let client = DropboxClientsManager.authorizedClient {
            return uploadData(data, with: client, completion: completion)
        }
        
        guard let vc = fromViewController else {
            let error = ExportError.fromViewControllerDeallocated
            let result = ExportResult(method: exportMethod, error: error)
            return completion(result)
        }
        
        createAuhorizedClient(from: vc)
        let result = ExportResult(method: exportMethod, state: .cancelled)
        return completion(result)
    }
    
    public func export(string: String, completion: @escaping ExportCompletion) {
        guard let data = string.data(using: .utf8, allowLossyConversion: false) else {
            let result = ExportResult(method: exportMethod, error: ExportError.invalidString)
            return completion(result)
        }
        export(data: data, completion: completion)
    }
}


// MARK: - Private Functions

private extension DropboxExporter {
    
    func uploadData(_ data: Data, with client: DropboxClient, completion: @escaping ExportCompletion) {
        let method = exportMethod
        let fileName = fileNameGenerator.getFileName()
        let path = "/\(fileName)"
        _ = client.files.upload(path: path, mode: .overwrite, autorename: true, clientModified: nil, mute: true, input: data).response { (_, error) in
            if let error = error {
                let error = ExportError.uploadError(description: error.description)
                let result = ExportResult(method: method, error: error)
                return completion(result)
            }
            let result = ExportResult(method: method, filePath: fileName)
            completion(result)
        }
    }
}
