//
//  ExportResult.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-05-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct represents the result of an export operation.
 
 It specifies the export method, current state as well as an optional error and export url.
 */
public struct ExportResult {
    
    public init(method: ExportMethod, state: ExportState, error: Error? = nil) {
        self.method = method
        self.state = state
        self.error = error
        self.filePath = nil
    }
    
    public init(method: ExportMethod, error: Error) {
        self.method = method
        self.state = .failed
        self.error = error
        self.filePath = nil
    }
    
    public init(method: ExportMethod, filePath: String) {
        self.method = method
        self.state = .completed
        self.error = nil
        self.filePath = filePath
    }
    
    public let method: ExportMethod
    public let state: ExportState
    public let error: Error?
    public let filePath: String?
}
