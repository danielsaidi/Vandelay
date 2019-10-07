//
//  MockDataExporter.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation
import Vandelay

class MockDataExporter: DataExporter, StringExporter {
    
    
    // MARK: - Initialization
    
    init(method: ExportMethod, result: ExportResult) {
        exportMethod = method
        exportResult = result
    }
    
    
    // MARK: - Properties
    
    var exportMethod: ExportMethod
    
    
    // MARK: - Mock Properties
    
    var exportResult: ExportResult
    var exportDataInvokeCount = 0
    var exportDataInvokeData = [Data]()
    var exportStringInvokeCount = 0
    var exportStringInvokeData = [String]()
    
    
    // MARK: - Functions
    
    func export(data: Data, completion: @escaping ExportCompletion) {
        exportDataInvokeCount += 1
        exportDataInvokeData.append(data)
        completion(exportResult)
    }
    
    func export(string: String, completion: @escaping ExportCompletion) {
        exportStringInvokeCount += 1
        exportStringInvokeData.append(string)
        completion(exportResult)
    }
}
