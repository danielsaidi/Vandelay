//
//  RandomFileNameGenerator.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Vandelay

class RandomFileNameGeneratorTests: QuickSpec {
    
    override func spec() {
        
        describe("getting file name") {
            
            it("returns random name wit provided extension component name") {
                let generator = RandomFileNameGenerator(fileExtension: "txt")
                let name = generator.getFileName()
                expect(name).to(endWith(".txt"))
                expect(name.count).to(equal(40))
            }
        }
    }
}
