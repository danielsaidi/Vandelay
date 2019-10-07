//
//  Photo.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-20.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit
import Vandelay

struct Photo: Codable {


    // MARK: - Initialization
    
    init(image: UIImage) {
        id = NSUUID().uuidString
        imageData = image.toData()
    }
    
    
    // MARK: - Properties
    
    let id: String
    let imageData: Data?
    
    var image: UIImage? {
        return imageData?.toImage()
    }
}


// MARK: - Data Extensions

private extension Data {

    func toImage() -> UIImage {
        return UIImage(data: self) ?? UIImage()
    }
}


// MARK: - UIImage Extensions

private extension UIImage {
    
    func toData() -> Data? {
        return self.pngData() ?? nil
    }
}
