//
//  ViewController.swift
//  VandelayExample
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import Vandelay

class ViewController: UITableViewController {
    
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        switch id {
        case "PhotoSegue":
            let vc = segue.destination as? PhotoViewController
            vc?.repository = photoRepository
        case "TodoSegue":
            let vc = segue.destination as? TodoItemViewController
            vc?.repository = todoItemRepository
        default: break
        }
    }
    
    
    // MARK: - Dependencies
    
    let todoItemRepository = TodoItemRepository()
    let photoRepository = PhotoRepository()

    
    // MARK: - Properties
    
    let photoFile = "photoAlbum.vdl"
    var photoUrl: URL { FileExporter(fileName: photoFile).getFileUrl()! }
    let todoFile = "todoList.vdl"
    var todoUrl: URL { FileExporter(fileName: todoFile).getFileUrl()! }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var exportPhotoAlbumCell: UITableViewCell!
    @IBOutlet weak var exportTodoItemsCell: UITableViewCell!
    @IBOutlet weak var importPhotoAlbumCell: UITableViewCell!
    @IBOutlet weak var importTodoItemsCell: UITableViewCell!
    @IBOutlet weak var photoAlbumCell: UITableViewCell!
    @IBOutlet weak var todoItemCell: UITableViewCell!
}


// MARK: - Public Functions

extension ViewController {
    
    func reloadData() {
        let items = todoItemRepository.getItems()
        let photos = photoRepository.getPhotos()
        todoItemCell.detailTextLabel?.text = "\(items.count) items"
        photoAlbumCell.detailTextLabel?.text = "\(photos.count) photos"
    }
}


// MARK: - UITableViewDelegate

extension ViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        switch cell {
        case exportPhotoAlbumCell: exportPhotoAlbum()
        case exportTodoItemsCell: exportTodoList()
        case importTodoItemsCell: importTodoList()
        case importPhotoAlbumCell: importPhotoAlbum()
        default: break
        }
    }
}
