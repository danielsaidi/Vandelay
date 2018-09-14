//
//  DropboxImporterTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-14.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Vandelay
import VandelayDropbox

class DropboxImporterTests: QuickSpec {
    
    override func spec() {
        
        var importer: Importer!
        
        beforeEach {
            importer = DropboxImporter(fromViewController: UIViewController(), fileName: "")
        }
        
        describe("import method") {
            
            it("is correct") {
                expect(importer.importMethod).to(equal(.dropbox))
            }
        }
    }
}
