//
//  ExportResult.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-05-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

public struct ExportResult {
    
    public init(method: ExportMethod, state: ExportState) {
        self.state = state
        self.exportMethod = method
    }
    
    public init(method: ExportMethod, error: Error) {
        self.state = .failed
        self.exportMethod = method
        self.error = error as NSError
    }
    
    public init(method: ExportMethod, errorMessage: String) {
        let domain = "com.vandelay.export.error"
        let userInfo = ["Description": errorMessage]
        let error = NSError(domain: domain, code: -1, userInfo: userInfo)
        self.init(method: method, error: error)
    }
    
    public var exportMethod: ExportMethod
    public var error: Error?
    public var filePath: String?
    public var state: ExportState
}
