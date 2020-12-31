//
//  MockDataImporter.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import MockingKit
import Vandelay

class MockDataImporter: Mock, DataImporter, StringImporter {
    
    init(method: ImportMethod, result: ImportResult) {
        importMethod = method
        importResult = result
    }
    
    lazy var importDataRef = MockReference(importData)
    lazy var importStringRef = MockReference(importString)
    
    let importMethod: ImportMethod
    let importResult: ImportResult
    
    func importData(completion: @escaping ImportCompletion) {
        invoke(importDataRef, args: (completion))
        completion(importResult)
    }
    
    func importString(completion: @escaping ImportCompletion) {
        invoke(importStringRef, args: (completion))
        completion(importResult)
    }
}
