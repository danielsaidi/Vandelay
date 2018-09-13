//
//  UrlImporterTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Vandelay

class UrlImporterTests: QuickSpec {
    
    override func spec() {
        
        var importer: Importer!
        
        beforeEach {
            let url = URL(string: "http://foo/bar")!
            importer = UrlImporter(url: url)
        }
        
        describe("import method") {
            
            it("is correct") {
                expect(importer.importMethod).to(equal(.url))
            }
        }
    }
}
