//
//  Photo.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-20.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 Since this class contains an NSData property, it will
 not be serializable to JSON. We must therefore export
 it with a data exporter instead of a string exporter.
 
 */

import UIKit
import Vandelay

class Photo: NSObject, NSCoding {

    
    // MARK: - Initialization
    
    init(image: UIImage) {
        id = UuidGenerator().generateUniqueId()
        super.init()
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as? String ?? ""
        imageData = coder.decodeObject(forKey: "imageData") as? Data ?? nil
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(imageData, forKey: "imageData")
    }
    
    
    
    // MARK: - Properties
    
    var id: String
    var imageData: Data?
    
    var image: UIImage {
        get { return imageData?.toImage() ?? UIImage() }
        set { imageData = newValue.toData() }
    }
}


fileprivate extension Data {
    func toImage() -> UIImage {
        return UIImage(data: self) ?? UIImage()
    }
}

fileprivate extension UIImage {
    func toData() -> Data? {
        return UIImagePNGRepresentation(self) ?? nil
    }
}
