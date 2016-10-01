//
//  PhotoRepository.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-21.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit
import Vandelay

class PhotoRepository : NSObject {
    
    
    // MARK: - Properties
    
    private var photos = [String : Photo]()
    
    
    
    // MARK: - Public functions
    
    func addPhoto(_ photo: Photo) {
        photos[photo.id] = photo
    }
    
    func deletePhoto(_ photo: Photo) {
        photos.removeValue(forKey: photo.id)
    }
    
    func getPhotos() -> [Photo] {
        return photos.values.sorted(by: { photo1, photo2 -> Bool in
            photo1.id < photo2.id
        })
    }
    
    func getPhoto(id: String) -> Photo? {
        return photos[id]
    }
}
