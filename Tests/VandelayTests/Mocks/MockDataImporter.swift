//
//  MockDataImporter.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Mockery
import Vandelay

class MockDataImporter: Mock, DataImporter, StringImporter {
    
    init(method: ImportMethod, result: ImportResult) {
        importMethod = method
        importResult = result
    }
    
    let importMethod: ImportMethod
    let importResult: ImportResult
    
    func importData(completion: @escaping ImportCompletion) {
        invoke(importData, args: (completion))
        completion(importResult)
    }
    
    func importString(completion: @escaping ImportCompletion) {
        invoke(importString, args: (completion))
        completion(importResult)
    }
}
