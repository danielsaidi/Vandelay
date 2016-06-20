//
//  Exporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-02.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol gives Vandelay exporters access to some
 basic exporter functions. You should not implement it
 directly, if you create your own exporter.
 
 */

import UIKit

public protocol Exporter {
    
    var exportMethod: String? { get }
}

public extension Exporter {
    
    public func getResultWithError(error: NSError) -> ExportResult {
        let result = ExportResult(state: .Failed)
        result.error = error
        return result
    }
    
    public func getResultWithErrorMessage(message: String) -> ExportResult {
        let domain = "Vandelay"
        let userInfo = ["Description" : message]
        let error = NSError(domain: domain, code: -1, userInfo: userInfo)
        return getResultWithError(error)
    }
    
    public func getResultWithFilePath(filePath: String) -> ExportResult {
        let result = ExportResult(state: .Completed)
        result.filePath = filePath
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