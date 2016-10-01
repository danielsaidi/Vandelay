//
//  QrCodeImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-10-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This importer can be used to import strings & data by
 scanning a QR code.
 
 Since url importing is asynchronous, you will receive
 two callbacks - one to tell you that the import begun,
 and one to tell you if it succeeded or failed.
 
 Due to security reasons in iOS10, you must add a text
 for the NSCameraUsageDescription key in Info.plist.
 
 */

import Foundation
import QRCodeReader
import Vandelay

public class QrCodeImporter: NSObject, DataImporter, StringImporter {
    
    
    // MARK: Initialization
    
    public init(vc: UIViewController) {
        self.vc = vc
        super.init()
    }
    
 
 
    // MARK: - Properties
 
    public var importMethod: String { return "QR" }
    
    public var errorMessageForInvalidUrl = "QrCodeImporter did not scan a valid url"
    public var errorMessageForNoResult = "QrCodeImporter did not receive any result"
    public var errorMessageForUnavailableReader = "The device does not support scanning QR codes"
    
    private var readerVc: QRCodeReaderViewController?
    private weak var vc: UIViewController?
    
    
    
    // MARK: - Functions
    
    public func importData(completion: ((_ result: ImportResult) -> ())?) {
        guard let vc = vc else { return }
        guard let reader = createReader(completion) else { return }
        
        reader.completionBlock = { result in
            guard let importer = self.getImporter(for: result, completion: completion) else { return }
            importer.importData(completion: completion)
            if let reader = self.readerVc { reader.dismiss(animated: true) }
        }
        
        vc.present(reader, animated: true, completion: nil)
    }
    
    public func importString(completion: ((_ result: ImportResult) -> ())?) {
        guard let vc = vc else { return }
        guard let reader = createReader(completion) else { return }
        
        reader.completionBlock = { result in
            guard let importer = self.getImporter(for: result, completion: completion) else { return }
            importer.importString(completion: completion)
            if let reader = self.readerVc { reader.dismiss(animated: true) }
        }
        
        vc.present(reader, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Private functions
    
    private func createReader(_ completion: ((_ result: ImportResult) -> ())?) -> QRCodeReaderViewController? {
        guard QRCodeReader.isAvailable() else {
            completion?(self.getResult(withErrorMessage: self.errorMessageForUnavailableReader))
            return nil
        }
        
        let new =  QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader()
        })
        new.modalPresentationStyle = .formSheet
        readerVc = new
        
        return new
    }
    
    private func getImporter(for result: QRCodeReaderResult?, completion: ((_ result: ImportResult) -> ())?) -> UrlImporter? {
        guard let url = getUrl(from: result, completion: completion) else { return nil }
        return UrlImporter(url: url)
    }
    
    private func getUrl(from result: QRCodeReaderResult?, completion: ((_ result: ImportResult) -> ())?) -> URL? {
        guard let result = result else {
            completion?(self.getResult(withErrorMessage: self.errorMessageForNoResult))
            return nil
        }
        
        guard let url = URL(string: result.value) else {
            completion?(self.getResult(withErrorMessage: self.errorMessageForInvalidUrl))
            return nil
        }
        
        return url
    }
}
