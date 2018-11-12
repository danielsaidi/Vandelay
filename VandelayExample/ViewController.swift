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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "NavBarLogo")
        navigationItem.titleView = UIImageView(image: image)
    }
    
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
    
    let photoFile = "photoAlbum.json"
    var photoPath: String { return "http://danielsaidi.com/vandelay/\(photoFile)" }
    var photoUrl: URL { return URL(string: photoPath)! }
    let todoFile = "todoList.json"
    var todoPath: String { return "http://danielsaidi.com/vandelay/\(todoFile)" }
    var todoUrl: URL { return URL(string: todoPath)! }
    
    
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
    
    func handleExportResult(_ result: ExportResult) {
        alert(title: "Done", message: result.message)
    }
    
    func handleImportResult(_ result: ImportResult) {
        alert(title: "Done", message: result.message)
    }
    
    func reloadData() {
        let items = todoItemRepository.getItems()
        let photos = photoRepository.getPhotos()
        todoItemCell.detailTextLabel?.text = "\(items.count) items"
        photoAlbumCell.detailTextLabel?.text = "\(photos.count) photos"
    }
}


// MARK: - Private Functions

private extension ViewController {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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


// MARK: - ExportResult Extensions

extension ExportResult {
    
    var message: String {
        switch state {
        case .cancelled: return "The export was cancelled."
        case .completed: return "The export was successfully completed."
        case .failed: return "The export did fail: \(error?.localizedDescription ?? "No error information")."
        }
    }
}


// MARK: - ImportResult Extensions

extension ImportResult {
    
    var message: String {
        switch state {
        case .cancelled: return "The import was cancelled."
        case .completed: return "The import was successfully completed."
        case .failed: return "The import did fail: \(error?.localizedDescription ?? "No error information")."
        }
    }
}
