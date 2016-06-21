//
//  PhotoViewController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-21.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class PhotoViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    // MARK: View lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.backgroundColor = UIColor.whiteColor()
        reloadData()
    }
    
    
    
    // MARK: Properties
    
    var repository: PhotoRepository?
    
    private var hasPhotos: Bool { return photos.count > 0 }
    private var photos = [Photo]()
    
    
    
    
    // MARK: Actions
    
    @IBAction func add() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
    
    // MARK: Private functions
    
    private func reloadData() {
        photos = repository?.getPhotos() ?? [Photo]()
        collectionView?.reloadData()
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell.imageView.image = photo.image
        return cell
    }
    
    
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        repository?.addPhoto(Photo(image: image.resizeToWidth(250)))
        dismissViewControllerAnimated(true, completion: nil)
        reloadData()
    }
}



