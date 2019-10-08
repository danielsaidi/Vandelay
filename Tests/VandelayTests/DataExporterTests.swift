//
//  DataExporterTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Foundation
import Vandelay

class DataExporterTests: QuickSpec {
    
    override func spec() {
        
        var result: ExportResult!
        var exporter: MockDataExporter!
        
        beforeEach {
            result = ExportResult(method: .email, filePath: "foo")
            exporter = MockDataExporter(method: .email, result: result)
        }
        
        describe("exporting data for valid codable") {
            
            it("calls base function with data") {
                exporter.exportData(for: TestClass(), encoder: JSONEncoder()) { (_) in }
                expect(exporter.exportDataInvokeCount).to(equal(1))
                expect(exporter.exportDataInvokeData.count).to(equal(1))
            }
            
            it("completes with export result") {
                exporter.exportData(for: TestClass(), encoder: JSONEncoder()) { result in
                    expect(result.method).to(equal(exporter.exportResult.method))
                }
            }
        }
    }
}

private class TestClass: Codable {
    
    let name: String = "Foo"
}
