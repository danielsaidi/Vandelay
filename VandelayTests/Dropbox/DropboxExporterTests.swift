//
//  DropboxExporterTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-14.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Vandelay
import VandelayDropbox

class DropboxExporterTests: QuickSpec {
    
    override func spec() {
        
        var exporter: Exporter!
        
        beforeEach {
            exporter = DropboxExporter(fromViewController: UIViewController(), fileName: "")
        }
        
        describe("export method") {
            
            it("is correct") {
                expect(exporter.exportMethod).to(equal(.dropbox))
            }
        }
    }
}
