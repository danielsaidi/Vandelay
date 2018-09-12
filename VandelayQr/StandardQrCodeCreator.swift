//
//  StandardQrCodeCreator.swift
//  Vandelay
//
//  Original: https://www.hackingwithswift.com/example-code/media/how-to-create-a-qr-code
//
//  Created by Daniel Saidi on 2016-10-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public class StandardQrCodeCreator: QrCodeCreator {
    
    
    // MARK: - Initialization
    
    public init(scale: Int = 1) {
        self.scale = scale
    }
    
    
    // MARK: - Properties
    
    private let scale: Int
    
    
    // MARK: - Functions
    
    public func createQrCode(fromUrl url: URL) -> UIImage? {
        return createQrCode(fromUrlString: url.absoluteString)
    }
    
    public func createQrCode(fromUrlString string: String) -> UIImage? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = string.data(using: .ascii)
        filter.setValue(data, forKey: "inputMessage")
        let cgScale = CGFloat(scale)
        let transform = CGAffineTransform(scaleX: cgScale, y: cgScale)
        guard let output = filter.outputImage?.transformed(by: transform) else { return nil }
        return UIImage(ciImage: output)
    }
}
