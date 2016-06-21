//
//  DataImportResult.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

public class DataImportResult: NSObject {
    
    public init(state: ImportState) {
        self.state = state
    }
    
    public var data: NSData?
    public var error: NSError?
    public var importMethod: String?
    public var state: ImportState
}
