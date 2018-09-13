//
//  StandardQrCodeGenerator.swift
//  Vandelay
//
//  Original: https://www.hackingwithswift.com/example-code/media/how-to-create-a-qr-code
//
//  Created by Daniel Saidi on 2016-10-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public class StandardQrCodeGenerator: QrCodeGenerator {
    
    
    // MARK: - Initialization
    
    public init(scale: Int = 1) {
        self.scale = scale
    }
    
    
    // MARK: - Properties
    
    private let scale: Int
    
    
    // MARK: - Error
    
    enum GeneratorError: Error {
        case
        emptyTransformResult,
        unavailableCiFilter
    }
    
    
    // MARK: - Functions
    
    public func generateQrCode(with url: URL) throws -> UIImage {
        return try generateQrCode(with: url.absoluteString)
    }
    
    public func generateQrCode(with urlString: String) throws -> UIImage {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { throw GeneratorError.unavailableCiFilter }
        let data = urlString.data(using: .ascii)
        filter.setValue(data, forKey: "inputMessage")
        let cgScale = CGFloat(scale)
        let transform = CGAffineTransform(scaleX: cgScale, y: cgScale)
        guard let output = filter.outputImage?.transformed(by: transform) else { throw GeneratorError.emptyTransformResult }
        return UIImage(ciImage: output)
    }
}
