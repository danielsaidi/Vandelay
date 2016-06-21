//
//  ViewController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 06/07/2016.
//  Copyright (c) 2016 Daniel Saidi. All rights reserved.
//

import UIKit
import Vandelay

class MainViewController: UITableViewController {

    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoRepository = PhotoMemoryRepository()
        todoItemRepository = TodoItemMemoryRepository()
    }
    
    override func viewWillAppear(animated: Bool) {
        let items = todoItemRepository.getTodoItems()
        let photos = photoRepository.getPhotos()
        todoItemCell.detailTextLabel?.text = "\(items.count) items"
        photoAlbumCell.detailTextLabel?.text = "\(photos.count) items"
    }
    
    
    
    // MARK: Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier ?? "" {
        case "PhotoSegue":
            let vc = segue.destinationViewController as! PhotoViewController
            vc.repository = self.photoRepository
        case "TodoSegue":
            let vc = segue.destinationViewController as! TodoViewController
            vc.repository = self.todoItemRepository
        default: break
        }
    }
    
    
    
    // MARK: Properties
    
    var todoItemRepository: TodoItemRepository!
    var photoRepository: PhotoRepository!
    
    
    
    // MARK: Outlets
    
    @IBOutlet weak var photoAlbumCell: UITableViewCell!
    @IBOutlet weak var todoItemCell: UITableViewCell!
    
    
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

