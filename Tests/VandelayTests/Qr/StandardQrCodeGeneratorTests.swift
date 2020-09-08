//
//  StandardQrCodeGeneratorTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
import Quick
import Nimble
import Vandelay

class StandardQrCodeGeneratorTests: QuickSpec {
    
    override func spec() {
        
        describe("generating code") {
            
            func result(for url: URL, scale: Int = 1) -> UIImage {
                let generator = StandardQrCodeGenerator(scale: scale)
                let code = try? generator.generateQrCode(with: url)
                return UIImage(cgImage: code!)
            }
            
            func result(for urlString: String) -> UIImage {
                let generator = StandardQrCodeGenerator(scale: 1)
                let code = try? generator.generateQrCode(with: urlString)
                return UIImage(cgImage: code!)
            }
            
            it("can generate correctly sized code with valid url") {
                let code = result(for: URL(string: "http://foo/bar")!)
                expect(code.scale).to(equal(1))
                expect(code.size.width).to(equal(27))
                expect(code.size.height).to(equal(27))
            }
            
            it("can generate correctly sized code with invalid url string") {
                let code = result(for: "")
                expect(code.scale).to(equal(1))
                expect(code.size.width).to(equal(23))
                expect(code.size.height).to(equal(23))
            }
            
            it("can generate correctly scaled code with valid url string") {
                let code = result(for: URL(string: "http://foo/bar")!, scale: 4)
                expect(code.scale).to(equal(1))
                expect(code.size.width).to(equal(27*4))
                expect(code.size.height).to(equal(27*4))
            }
            
            it("can generate correctly sized code with super long url") {
                let url = URL(string: "http://foo/bar/baz/this/is/a/long/url/foo/bar/baz/this/is/a/long/url/foo/bar/baz/this/is/a/long/url")!
                let code = result(for: url)
                expect(code.scale).to(equal(1))
                expect(code.size.width).to(equal(43))
                expect(code.size.height).to(equal(43))
            }
        }
    }
}
