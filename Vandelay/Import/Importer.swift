//
//  Importer.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol gives Vandelay importers access to core
 import functionality. It should not be implemented by
 classes outside of Vandelay.
 
 */

import UIKit

public protocol Importer {
    
    var importMethod: String { get }
}

public extension Importer {
    
    public var topmostViewController: UIViewController? {
        guard var vc = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        while let pvc = vc.presentedViewController {
            vc = pvc
        }
        return vc
    }
    
    
    public func getResult(withData data: Data) -> ImportResult {
        let result = ImportResult(state: .completed)
        result.data = data
        result.importMethod = importMethod
        return result
    }
    
    public func getResult(withError error: NSError) -> ImportResult {
        let result = ImportResult(state: .failed)
        result.error = error
        result.importMethod = importMethod
        return result
    }
    
    public func getResult(withError error: Error) -> ImportResult {
        return getResult(withErrorMessage: error.localizedDescription)
    }
    
    public func getResult(withErrorMessage message: String) -> ImportResult {
        let domain = "Vandelay"
        let userInfo = ["Description": message]
        let error = NSError(domain: domain, code: -1, userInfo: userInfo)
        return getResult(withError: error)
    }
    
    public func getResult(withState state: ImportState) -> ImportResult {
        let result = ImportResult(state: state)
        result.importMethod = importMethod
        return result
    }
    
    public func getResult(withString string: String) -> ImportResult {
        let result = ImportResult(state: .completed)
        result.string = string
        result.importMethod = importMethod
        return result
    }
}
