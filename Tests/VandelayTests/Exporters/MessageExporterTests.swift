//
//  MessageExporterTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

#if !os(macOS)
import Quick
import Nimble
import Foundation
import Vandelay
import UIKit

class MessageExporterTests: QuickSpec {
    
    override func spec() {
        
        var exporter: Exporter!
        
        beforeEach {
            exporter = MessageExporter(fromViewController: UIViewController(), fileName: "foo")
        }
        
        describe("export method") {
            
            it("is correct") {
                expect(exporter.exportMethod).to(equal(.message))
            }
        }
    }
}
#endif
