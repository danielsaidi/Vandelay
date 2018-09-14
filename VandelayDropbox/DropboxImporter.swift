//
//  DropboxImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-03.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This importer can import strings and data from Dropbox. You
 must create it with a static file name.
 
 */

/*
 
 Instructions:
 
 Before using this importer, make sure that Dropbox has been
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
 
 IMPORTANT: If you do not handle the exporter callback, your
 app will never be authorized, and will keep asking for this
 permission each time this exporter is used. Look at the app
 `AppDelegate.swift` to see how to handle the auth result.
 
 */


import Foundation
import SwiftyDropbox
import Vandelay

public class DropboxImporter: DataImporter, StringImporter, DropboxClientCreator {
    
    
    // MARK: Initialization
    
    public init(fromViewController: UIViewController, fileName: String) {
        self.fromViewController = fromViewController
        self.fileName = fileName
    }
    
    
    // MARK: Properties
    
    public let importMethod = ImportMethod.dropbox
    
    private let fileName: String
    private weak var fromViewController: UIViewController?
    
    
    // MARK: - Error
    
    enum ImportError: Error {
        case
        downloadError(description: String),
        fromViewControllerDeallocated,
        invalidFileData,
        invalidResponse,
        invalidStringData
    }
    
    
    // MARK: Public functions
    
    public func importData(completion: @escaping ImportCompletion) {
        if let client = DropboxClientsManager.authorizedClient {
            return importData(with: client, completion: completion)
        }
        
        guard let vc = fromViewController else {
            let error = ImportError.fromViewControllerDeallocated
            let result = ImportResult(method: importMethod, error: error)
            return completion(result)
        }
        
        createAuhorizedClient(from: vc)
        let result = ImportResult(method: importMethod, state: .cancelled)
        return completion(result)
    }
    
    public func importString(completion: @escaping ImportCompletion) {
        let method = importMethod
        importData { result in
            guard let data = result.data else {
                return completion(result)
            }
            
            guard let string = String(data: data, encoding: .utf8) else {
                let error = ImportError.invalidStringData
                let result = ImportResult(method: method, error: error)
                return completion(result)
            }
            
            let result = ImportResult(method: method, string: string)
            completion(result)
        }
    }
}


// MARK: - Private Functions

private extension DropboxImporter {
    
    func getDownloadDestination() -> ((URL, HTTPURLResponse) -> URL) {
        return { temporaryURL, response in
            let fileManager = FileManager.default
            let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let pathComponent = "\(NSUUID().uuidString)-\(response.suggestedFilename!)"
            return directoryURL.appendingPathComponent(pathComponent)
        }
    }
    
    func importData(with client: DropboxClient, completion: @escaping ImportCompletion) {
        let method = importMethod
        let filePath = "/\(fileName)"
        let destination = getDownloadDestination()
        _ = client.files.download(path: filePath, destination: destination).response { response, error in
            if let error = error {
                let error = ImportError.downloadError(description: error.description)
                let result = ImportResult(method: method, error: error)
                return completion(result)
            }
            
            guard let url = response?.1 else {
                let error = ImportError.invalidResponse
                let result = ImportResult(method: method, error: error)
                return completion(result)
            }
            
            do {
                let data = try Data(contentsOf: url)
                let result = ImportResult(method: method, data: data)
                completion(result)
            } catch {
                let error = ImportError.invalidFileData
                let result = ImportResult(method: method, error: error)
                completion(result)
            }
        }
    }
}
