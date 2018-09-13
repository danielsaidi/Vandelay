//
//  StaticFileNameGeneratorTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Vandelay

class StaticFileNameGeneratorTests: QuickSpec {
    
    override func spec() {
        
        describe("getting file name") {
            
            it("returns single component name") {
                let generator = StaticFileNameGenerator(fileName: "foo")
                let name = generator.getFileName()
                expect(name).to(equal("foo"))
            }
            
            it("returns name and extension based name") {
                let generator = StaticFileNameGenerator(fileName: "foo", fileExtension: "bar")
                let name = generator.getFileName()
                expect(name).to(equal("foo.bar"))
            }
        }
    }
}
