//
//  Photo.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-20.
//  Copyright © 2016 CocoaPods. All rights reserved.
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

    
    // MARK: Initialization
    
    init(image: UIImage) {
        super.init()
        id = UuidGenerator().generateUniqueId()
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        super.init()
        id = coder.decodeObjectForKey("id") as? String ?? ""
        imageData = coder.decodeObjectForKey("imageData") as? NSData
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(id, forKey: "id")
        coder.encodeObject(imageData, forKey: "imageData")
    }
    
    
    
    // MARK: Properties
    
    var id = ""
    var imageData: NSData?
    
    var image: UIImage {
        get { return dataToImage(imageData) }
        set { imageData = imageToData(newValue) }
    }
    
    
    
    // MARK: Private functions
    
    private func dataToImage(data: NSData?) -> UIImage {
        if (data == nil) {
            return UIImage()
        }
        return UIImage(data: data!) ?? UIImage()
    }
    
    private func imageToData(image: UIImage?) -> NSData? {
        if (image == nil) {
            return nil
        }
        return UIImagePNGRepresentation(image!)
    }
}
