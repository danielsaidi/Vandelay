//
//  PasteboardImporterTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

#if !os(macOS)
import Quick
import Nimble
import Vandelay

class PasteboardImporterTests: QuickSpec {
    
    override func spec() {
        
        var importer: Importer!
        
        beforeEach {
            importer = PasteboardImporter()
        }
        
        describe("import method") {
            
            it("is correct") {
                expect(importer.importMethod).to(equal(.pasteboard))
            }
        }
    }
}
#endif
