//
//  Exporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-02.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol gives Vandelay exporters access to core
 export functionality. It should not be implemented by
 classes outside of Vandelay.
 
 */

import UIKit

public protocol Exporter {
    
    var exportMethod: String { get }
}

public extension Exporter {
    
    public var topmostViewController: UIViewController? {
        guard var vc = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        while let pvc = vc.presentedViewController {
            vc = pvc
        }
        return vc
    }
    
    
    
    public func getResult(withError error: NSError) -> ExportResult {
        let result = ExportResult(state: .failed)
        result.error = error
        result.exportMethod = exportMethod
        return result
    }
    
    public func getResult(withErrorMessage errorMessage: String) -> ExportResult {
        let domain = "Vandelay"
        let userInfo = ["Description" : errorMessage]
        let error = NSError(domain: domain, code: -1, userInfo: userInfo)
        return getResult(withError: error)
    }
    
    public func getResult(withFilePath filePath: String) -> ExportResult {
        let result = ExportResult(state: .completed)
        result.exportMethod = exportMethod
        result.filePath = filePath
        return result
    }
    
    public func getResult(withState state: ExportState) -> ExportResult {
        let result = ExportResult(state: state)
        result.exportMethod = exportMethod
        return result
    }
}
