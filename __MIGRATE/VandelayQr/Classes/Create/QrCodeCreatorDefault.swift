//
//  QrCodeCreatorDefault.swift
//  Vandelay
//
//  Original: https://www.hackingwithswift.com/example-code/media/how-to-create-a-qr-code
//
//  Created by Daniel Saidi on 2016-10-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

class QrCodeCreatorDefault: NSObject, QrCodeCreator {
    
    
    // MARK: - Initialization
    
    init(scale: Int) {
        self.scale = scale
        super.init()
    }
    
    
    
    // MARK: - Properties
    
    private var scale: Int
    
    
    
    // MARK: - Functions
    
    func createQrCode(fromUrl url: URL) -> UIImage? {
        return createQrCode(fromUrlString: url.absoluteString)
    }
    
    func createQrCode(fromUrlString string: String) -> UIImage? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = string.data(using: .ascii)
        filter.setValue(data, forKey: "inputMessage")
        let cgScale = CGFloat(scale)
        let transform = CGAffineTransform(scaleX: cgScale, y: cgScale)
        guard let output = filter.outputImage?.transformed(by: transform) else { return nil }
        return UIImage(ciImage: output)
    }
}
