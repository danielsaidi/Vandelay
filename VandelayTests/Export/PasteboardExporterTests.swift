//
//  PasteboardExporterTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Vandelay

class PasteboardExporterTests: QuickSpec {
    
    override func spec() {
        
        var exporter: Exporter!
        
        beforeEach {
            exporter = PasteboardExporter()
        }
        
        describe("export method") {
            
            it("is correct") {
                expect(exporter.exportMethod).to(equal(.pasteboard))
            }
        }
    }
}
