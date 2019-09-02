//
//  MockDataImporter.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Vandelay

class MockDataImporter: DataImporter, StringImporter {
    
    
    // MARK: - Initialization
    
    init(method: ImportMethod, result: ImportResult) {
        importMethod = method
        importResult = result
    }
    
    
    // MARK: - Properties
    
    var importMethod: ImportMethod
    
    
    // MARK: - Mock Properties
    
    var importResult: ImportResult
    var importDataInvokeCount = 0
    var importStringInvokeCount = 0
    
    
    // MARK: - Functions
    
    func importData(completion: @escaping ImportCompletion) {
        importDataInvokeCount += 1
        completion(importResult)
    }
    
    func importString(completion: @escaping ImportCompletion) {
        importStringInvokeCount += 1
        completion(importResult)
    }
}
