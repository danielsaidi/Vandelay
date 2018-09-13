//
//  QrCodeGenerator.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-10-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public protocol QrCodeGenerator {
    
    func generateQrCode(with url: URL) throws -> UIImage
    func generateQrCode(with urlString: String) throws -> UIImage
}
