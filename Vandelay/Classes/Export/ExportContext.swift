//
//  ExportContext.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-02.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public protocol ExportContext {
    
    var context: String? { get }
}

public extension ExportContext {
    
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