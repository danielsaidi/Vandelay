//
//  PhotoViewController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-21.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

class PhotoViewController: UICollectionViewController {

    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.backgroundColor = .white
        reloadData()
    }
    
    
    // MARK: - Properties
    
    var repository: PhotoRepository!
    
    private var photos = [Photo]()
}


// MARK: - Actions

@objc extension PhotoViewController {
    
    func add() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
}


// MARK: - Private Functions

private extension PhotoViewController {
    
    func reloadData() {
        photos = repository.getPhotos()
        collectionView?.reloadData()
    }
}


// MARK: - UICollectionViewDataSource

extension PhotoViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        guard let photoCell = cell as? PhotoCollectionViewCell else { return cell }
        let photo = photos[indexPath.row]
        photoCell.imageView.image = photo.image
        return photoCell
    }
}


// MARK: - UIImagePickerControllerDelegate

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let imageData = info[UIImagePickerControllerOriginalImage] as? UIImage
        guard let image = imageData else { return print("No image data") }
        let photo = Photo(image: image.resized(toWidth: 250))
        repository.add(photo)
        dismiss(animated: true, completion: nil)
        reloadData()
    }
}
