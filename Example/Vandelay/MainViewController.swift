//
//  ViewController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 06/07/2016.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit
import Vandelay

class MainViewController: UITableViewController, ExportDataProvider {

    
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
            let vc = segue.destinationViewController as! TodoItemViewController
            vc.repository = self.todoItemRepository
        default: break
        }
    }
    
    
    
    // MARK: Properties
    
    var todoItemRepository: TodoItemRepository!
    var photoRepository: PhotoRepository!
    
    
    
    // MARK: Outlets
    
    @IBOutlet weak var exportPhotoAlbumCell: UITableViewCell!
    @IBOutlet weak var exportTodoItemsCell: UITableViewCell!
    @IBOutlet weak var importPhotoAlbumCell: UITableViewCell!
    @IBOutlet weak var importTodoItemsCell: UITableViewCell!
    @IBOutlet weak var photoAlbumCell: UITableViewCell!
    @IBOutlet weak var todoItemCell: UITableViewCell!
    
    
    
    // MARK: Private functions
    
    private func exportPhotoAlbum() {
        let title = "Export Photo Album"
        let message = "How do you want to export this album?"
        let alert = ExportAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alert.dataProvider = self
        alert.completion = exportCompletedWithResult
        alert.addDataExporter(EmailExporter(fileName: "photos.vandelay"), withTitle: "As an e-mail attachment")
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func exportTodoItems() {
        let title = "Export Todo List"
        let message = "How do you want to export this list?"
        let alert = ExportAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alert.dataProvider = self
        alert.completion = exportCompletedWithResult
        alert.addStringExporter(PasteboardExporter(), withTitle: "To the pasteboard")
        alert.addStringExporter(EmailExporter(fileName: "todoList.vandelay"), withTitle: "As an e-mail attachment")
        alert.addStringExporter(FileExporter(fileName: "todoList.vandelay"), withTitle: "To a local file")
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func exportCompletedWithResult(result: ExportResult) {
        let title = "Hey!"
        let message = getExportMessageForResult(result)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func getExportMessageForResult(result: ExportResult) -> String {
        if (result.filePath != nil) {
            return "Your data was exported to \(result.filePath!)"
        }
        
        switch result.state {
        case .Cancelled:
            return "Your export was cancelled."
        case .Completed:
            return "Your data was exported, using the \"\(result.exportMethod!)\" export method"
        case .Failed:
            return "Your export failed with error \(result.error?.description)."
        case .InProgress:
            return "Your export is in progress. Please wait."
        }
    }
    
    
    
    // MARK: ExportDataProvider
    
    func getExportData(completion: ((data: NSData?) -> ())) {
        let photos = photoRepository.getPhotos()
        let data = NSKeyedArchiver.archivedDataWithRootObject(photos)
        completion(data: data)
    }
    
    func getExportDataString(completion: ((string: String?) -> ())) {
        let items = todoItemRepository.getTodoItems()
        let dicts = items.map { $0.toDictionary() }
        let json = JsonSerializer().serializeObject(dicts).result
        completion(string: json)
    }
    
    
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        switch cell {
        case exportPhotoAlbumCell: exportPhotoAlbum()
        case exportTodoItemsCell: exportTodoItems()
        case importPhotoAlbumCell: fallthrough
        case importTodoItemsCell:
            let title = "Coming soon"
            let message = "We are working on this"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        default: break
        }
    }
}

