//
//  PhotoRepository.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-21.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

protocol PhotoRepository {
    func addPhoto(photo: Photo)
    func deletePhoto(photo: Photo)
    func getPhotos() -> [Photo]
    func getPhoto(id: String) -> Photo?
}
