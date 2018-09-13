//
//  StandardQrCodeGeneratorTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Vandelay
import VandelayQr

class StandardQrCodeGeneratorTests: QuickSpec {
    
    override func spec() {
        
        describe("generating code") {
            
            it("can generate correctly sized code with valid url") {
                let generator = StandardQrCodeGenerator(scale: 1)
                let url = URL(string: "http://foo/bar")!
                let code = try? generator.generateQrCode(with: url)
                expect(code?.scale).to(equal(1))
                expect(code?.size.width).to(equal(27))
                expect(code?.size.height).to(equal(27))
            }
            
            it("can generate correctly sized code with valid url string") {
                let generator = StandardQrCodeGenerator(scale: 1)
                let code = try? generator.generateQrCode(with: "http://foo/bar")
                expect(code?.scale).to(equal(1))
                expect(code?.size.width).to(equal(27))
                expect(code?.size.height).to(equal(27))
            }
            
            it("can generate correctly sized code with invalid url string") {
                let generator = StandardQrCodeGenerator(scale: 1)
                let code = try? generator.generateQrCode(with: "")
                expect(code?.scale).to(equal(1))
                expect(code?.size.width).to(equal(23))
                expect(code?.size.height).to(equal(23))
            }
            
            it("can generate correctly scaled code with valid url string") {
                let generator = StandardQrCodeGenerator(scale: 4)
                let code = try? generator.generateQrCode(with: "http://foo/bar")
                expect(code?.scale).to(equal(1))
                expect(code?.size.width).to(equal(27*4))
                expect(code?.size.height).to(equal(27*4))
            }
            
            it("can generate correctly sized code with super long url") {
                let generator = StandardQrCodeGenerator(scale: 1)
                let url = URL(string: "http://foo/bar/baz/this/is/a/long/url/foo/bar/baz/this/is/a/long/url/foo/bar/baz/this/is/a/long/url")!
                let code = try? generator.generateQrCode(with: url)
                expect(code?.scale).to(equal(1))
                expect(code?.size.width).to(equal(43))
                expect(code?.size.height).to(equal(43))
            }
        }
    }
}
