//
//  PasteboardExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-22.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can export strings to the pasteboard.
 
 */

import UIKit

public class PasteboardExporter: StringExporter {
    
    
    // MARK: - Initialization
    
    public init() {
        exportMethod = .pasteboard
    }
    
    
    // MARK: - Properties
    
    public let exportMethod: ExportMethod

    
    // MARK: - StringExporter
    
    public func export(string: String, completion: @escaping ExportCompletion) {
        UIPasteboard.general.string = string
        let result = ExportResult(method: exportMethod, state: .completed)
        completion(result)
    }
}
