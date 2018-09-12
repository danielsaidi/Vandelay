//
//  ExporterTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Vandelay

class ExporterTests: QuickSpec {
    
    override func spec() {
        
        var exporter: Exporter!
        
        beforeEach {
            let result = ExportResult(method: .message, filePath: "")
            exporter = MockDataExporter(method: .email, result: result)
        }
        
        describe("getting data for encodable object") {
            
            it("returns data representation of object") {
                let obj = TestClass()
                let data = try? exporter.getData(for: obj)
                let string = String(data: data!, encoding: .utf8)
                expect(string).to(equal("{\"name\":\"Foo\"}"))
            }
        }
        
        describe("getting string for encodable object") {
            
            it("returns data representation of object") {
                let obj = TestClass()
                let string = try? exporter.getString(for: obj)
                expect(string).to(equal("{\"name\":\"Foo\"}"))
            }
        }
    }
}

private class TestClass: Codable {
    
    let name: String = "Foo"
}
