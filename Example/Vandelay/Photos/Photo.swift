//
//  Photo.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-20.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 Since this class contains an NSData property, it will
 not be serializable to JSON. We will therefore export
 it with a data exporter, by implementing NSCoding.
 
 If you can sync such NSData properties in another way
 and have classes only contain serializable properties,
 you could use string exports for all your objects and
 export more complex data in an easier way.
 
 */

import UIKit
import Vandelay

class Photo: NSObject, NSCoding {

    
    // MARK: - Initialization
    
    init(image: UIImage) {
        super.init()
        id = UuidGenerator().generateUniqueId()
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        super.init()
        id = coder.decodeObject(forKey: "id") as? String ?? ""
        imageData = coder.decodeObject(forKey: "imageData") as? Data
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(imageData, forKey: "imageData")
    }
    
    
    
    // MARK: - Properties
    
    var id = ""
    var imageData: Data?
    
    var image: UIImage {
        get { return imageData != nil ? imageData!.toImage() : UIImage() }
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
        return UIImagePNGRepresentation(self)
    }
}
