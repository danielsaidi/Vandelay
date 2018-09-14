//
//  PhotoRepository.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-21.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Vandelay

class PhotoRepository {
    
    
    // MARK: - Properties
    
    private var photos = [String: Photo]()
    
    
    // MARK: - Public functions
    
    func add(_ photo: Photo) {
        photos[photo.id] = photo
    }
    
    func add(_ photos: [Photo]) {
        photos.forEach { add($0) }
    }
    
    func delete(_ photo: Photo) {
        photos.removeValue(forKey: photo.id)
    }
    
    func getPhotos() -> [Photo] {
        return photos.values.sorted { $0.id < $1.id }
    }
    
    func getPhoto(withId id: String) -> Photo? {
        return photos[id]
    }
}
