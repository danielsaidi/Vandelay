//
//  QrCodeGenerator.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-10-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 This protocol can be implemented by classes that can create
 a QR code image for a certain URL.
 */
public protocol QrCodeGenerator {
    
    func generateQrCode(with url: URL) throws -> CGImage
    func generateQrCode(with urlString: String) throws -> CGImage
}
