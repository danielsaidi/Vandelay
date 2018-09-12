//
//  QrCodeImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-10-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This importer can import strings and data by scanning codes
 that contain embedded urls.
 
 IMPORTANT: Since this importer opens a QR code scanner, you
 must keep a strong reference to it to avoid that it becomes
 deallocated while you complete the import.
 
 IMPORTANT: Due to extended security in iOS 10, you must add
 a text for the `NSCameraUsageDescription` key in Info.plist.
 Otherwise, your app will crash. You must also give it valid
 permissions to request external urls, if the user should be
 able to scan QR codes that contain external urls.
 
 */

import QRCodeReader
import Vandelay

public class QrCodeImporter: DataImporter, StringImporter {
    
    
    // MARK: Initialization
    
    public init(fromViewController: UIViewController) {
        self.fromViewController = fromViewController
    }
    
    
    // MARK: - Properties
 
    public let importMethod = ImportMethod.qrCode
    
    private weak var fromViewController: UIViewController?

    
    // MARK: - Errors
    
    enum ImportError: Error {
        case
        fromViewControllerDeallocated,
        noContentDetected,
        noUrlDetected,
        unsupportedDevice
    }
    
    
    // MARK: - DataImporter
    
    public func importData(completion: @escaping ImportCompletion) {
        let method = importMethod
        getUrlFromQrCodeScanner { (url, error) in
            if let error = error {
                let result = ImportResult(method: method, error: error)
                return completion(result)
            }
            
            guard let url = url else {
                let result = ImportResult(method: method, error: ImportError.noUrlDetected)
                return completion(result)
            }
            
            let importer = UrlImporter(url: url)
            importer.importData(completion: completion)
        }
    }
    
    
    // MARK: - StringImporter
    
    public func importString(completion: @escaping ImportCompletion) {
        let method = importMethod
        getUrlFromQrCodeScanner { (url, error) in
            if let error = error {
                let result = ImportResult(method: method, error: error)
                return completion(result)
            }
            
            guard let url = url else {
                let result = ImportResult(method: method, error: ImportError.noUrlDetected)
                return completion(result)
            }
            
            let importer = UrlImporter(url: url)
            importer.importString(completion: completion)
        }
    }
}


// MARK: - Private Functions

private extension QrCodeImporter {
    
    func getUrlFromQrCodeScanner(completion: @escaping (URL?, ImportError?) -> ()) {
        guard let vc = fromViewController else { return completion(nil, .fromViewControllerDeallocated) }
        guard QRCodeReader.isAvailable() else { return completion(nil, .unsupportedDevice)}
        
        let builder = QRCodeReaderViewControllerBuilder { $0.reader = QRCodeReader() }
        let scanner = QRCodeReaderViewController(builder: builder)
        scanner.modalPresentationStyle = .formSheet
        scanner.completionBlock = { [weak self] result in
            scanner.dismiss(animated: true)
            self?.parseUrl(from: result, completion: completion)
        }
        vc.present(scanner, animated: true, completion: nil)
    }
    
    func parseUrl(from result: QRCodeReaderResult?, completion: @escaping (URL?, ImportError?) -> ()) {
        guard let result = result else { return completion(nil, .noContentDetected) }
        guard let url = URL(string: result.value) else { return completion(nil, .noUrlDetected) }
        completion(url, nil)
    }
}
