//
//  MockDataExporter.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation
import Mockery
import Vandelay

class MockDataExporter: Mock, DataExporter, StringExporter {
    
    
    init(method: ExportMethod, result: ExportResult) {
        exportMethod = method
        exportResult = result
    }
    
    let exportMethod: ExportMethod
    let exportResult: ExportResult
    
    func export(data: Data, completion: @escaping ExportCompletion) {
        invoke(export, args: (data, completion))
        completion(exportResult)
    }
    
    func export(string: String, completion: @escaping ExportCompletion) {
        invoke(export, args: (string, completion))
        completion(exportResult)
    }
}
