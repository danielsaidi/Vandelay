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
    
    public func getResultWithData(data: NSData) -> ImportResult {
        let result = ImportResult(state: .Completed)
        result.data = data
        result.importMethod = importMethod
        return result
    }
    
    public func getResultWithError(error: NSError) -> ImportResult {
        let result = ImportResult(state: .Failed)
        result.error = error
        result.importMethod = importMethod
        return result
    }
    
    public func getResultWithErrorMessage(message: String) -> ImportResult {
        let domain = "Vandelay"
        let userInfo = ["Description" : message]
        let error = NSError(domain: domain, code: -1, userInfo: userInfo)
        return getResultWithError(error)
    }
    
    public func getResultWithState(state: ImportState) -> ImportResult {
        let result = ImportResult(state: state)
        result.importMethod = importMethod
        return result
    }
    
    public func getResultWithString(string: String) -> ImportResult {
        let result = ImportResult(state: .Completed)
        result.string = string
        result.importMethod = importMethod
        return result
    }
    
    public func getTopmostViewController() -> UIViewController? {
        if var vc = UIApplication.sharedApplication().keyWindow?.rootViewController {
            while let presentedViewController = vc.presentedViewController {
                vc = presentedViewController
            }
            return vc
        }
        return nil
    }
}