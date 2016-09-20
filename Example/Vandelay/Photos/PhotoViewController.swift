//
//  PhotoViewController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-21.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

class PhotoViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.backgroundColor = UIColor.white
        reloadData()
    }
    
    
    
    // MARK: - Properties
    
    var repository: PhotoRepository?
    
    private var hasPhotos: Bool { return photos.count > 0 }
    private var photos = [Photo]()
    
    
    
    
    // MARK: - Actions
    
    @IBAction func add() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Private functions
    
    private func reloadData() {
        photos = repository?.getPhotos() ?? [Photo]()
        collectionView?.reloadData()
    }
    
    
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell.imageView.image = photo.image
        return cell
    }
    
    
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        guard let resized = image.resize(toWidth: 250) else { return }
        repository?.addPhoto(photo: Photo(image: resized))
        dismiss(animated: true, completion: nil)
        reloadData()
    }
}

