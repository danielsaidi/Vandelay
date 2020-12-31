//
//  MockDataExporter.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation
import MockingKit
import Vandelay

class MockDataExporter: Mock, DataExporter, StringExporter {
    
    
    init(method: ExportMethod, result: ExportResult) {
        exportMethod = method
        exportResult = result
    }
    
    lazy var exportDataRef = MockReference(export as (Data, @escaping ExportCompletion) -> Void)
    lazy var exportStringRef = MockReference(export as (String, @escaping ExportCompletion) -> Void)
    
    let exportMethod: ExportMethod
    let exportResult: ExportResult
    
    func export(data: Data, completion: @escaping ExportCompletion) {
        invoke(exportDataRef, args: (data, completion))
        completion(exportResult)
    }
    
    func export(string: String, completion: @escaping ExportCompletion) {
        invoke(exportStringRef, args: (string, completion))
        completion(exportResult)
    }
}
