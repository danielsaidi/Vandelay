//
//  ExportResult.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-05-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

public class ExportResult: NSObject {
    
    public init(state: ExportState) {
        self.state = state
    }
    
    public var exportMethod = ""
    public var error: Error?
    public var filePath: String?
    public var state: ExportState
}
