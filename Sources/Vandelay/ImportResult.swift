//
//  ImportResult.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct represents the result of an import operation.
 
 It specifies the import method, current state as well as the optional imported string or data and an optional error.
 */
public struct ImportResult {
    
    public init(method: ImportMethod, state: ImportState) {
        self.method = method
        self.state = state
        self.data = nil
        self.error = nil
        self.string = nil
    }
    
    public init(method: ImportMethod, string: String) {
        self.method = method
        self.state = .completed
        self.data = nil
        self.error = nil
        self.string = string
    }
    
    public init(method: ImportMethod, data: Data) {
        self.method = method
        self.state = .completed
        self.data = data
        self.error = nil
        self.string = nil
    }
    
    public init(method: ImportMethod, error: Error) {
        self.method = method
        self.state = .failed
        self.data = nil
        self.error = error
        self.string = nil
    }
    
    public let method: ImportMethod
    public let state: ImportState
    public let data: Data?
    public let error: Error?
    public let string: String?
}
