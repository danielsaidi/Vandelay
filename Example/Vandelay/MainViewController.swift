//
//  ViewController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 06/07/2016.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This class intentionally contains most of the code to
 handle the export and import of todo items and photos,
 so that you do not have to jump between many files to
 follow what happens.
 
 When you build your own app, it is strongly suggested
 that you break up the functionality in smaller pieces,
 like a TodoItemExporter and a TodoItemImporter.
 
 */

import UIKit
import Vandelay
import VandelayDropbox

class MainViewController: UITableViewController, ExportDataProvider {

    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        reloadData()
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
    
    let photoFileName = "photoAlbum.vandelay"
    let todoFileName = "todoList.vandelay"
    
    var todoItemRepository = TodoItemRepository()
    var photoRepository = PhotoRepository()
    
    
    
    // MARK: Outlets
    
    @IBOutlet weak var exportPhotoAlbumCell: UITableViewCell!
    @IBOutlet weak var exportTodoItemsCell: UITableViewCell!
    @IBOutlet weak var importPhotoAlbumCell: UITableViewCell!
    @IBOutlet weak var importTodoItemsCell: UITableViewCell!
    @IBOutlet weak var photoAlbumCell: UITableViewCell!
    @IBOutlet weak var todoItemCell: UITableViewCell!
    
    
    
    // MARK: Private functions
    
    private func alertTitle(title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func exportCompletedWithResult(result: ExportResult) {
        let title = "Hey!"
        let message = getExportMessageForResult(result)
        alertTitle(title, andMessage: message)
    }
    
    private func exportPhotoAlbum() {
        let title = "Export Photo Album"
        let message = "How do you want to export this album?"
        let alert = ExportAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alert.dataProvider = self
        alert.completion = exportCompletedWithResult
        alert.addDataExporter(EmailExporter(fileName: photoFileName), withTitle: "As an e-mail attachment")
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func exportTodoItems() {
        let title = "Export Todo List"
        let message = "How do you want to export this list?"
        let alert = ExportAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alert.dataProvider = self
        alert.completion = exportCompletedWithResult
        alert.addStringExporter(PasteboardExporter(), withTitle: "To the pasteboard")
        alert.addStringExporter(FileExporter(fileName: todoFileName), withTitle: "To a local file")
        alert.addStringExporter(DropboxExporter(fileName: todoFileName), withTitle: "To a Dropbox file")
        alert.addStringExporter(EmailExporter(fileName: todoFileName), withTitle: "As an e-mail attachment")
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
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
            return "Your data was exported, using the \"\(result.exportMethod!)\" method"
        case .Failed:
            return "Your export failed with error \(result.error?.description ?? "N/A")."
        case .InProgress:
            return "Your export is in progress. Please wait."
        }
    }
    
    func getImportMessageForResult(result: ImportResult) -> String {
        switch result.state {
        case .Cancelled:
            return "Your import was cancelled."
        case .Completed:
            return "Your data was imported, using the \"\(result.importMethod!)\" method"
        case .Failed:
            return "Your import failed with error \(result.error?.description ?? "N/A")."
        case .InProgress:
            return "Your import is in progress. Please wait."
        }
    }
    
    private func importTodoItems() {
        let title = "Import Todo List items"
        let message = "How do you want to import todo list items?"
        let alert = ImportAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alert.completion = importTodoItemsCompletedWithResult
        alert.addStringImporter(PasteboardImporter(), withTitle: "From the pasteboard")
        alert.addStringImporter(FileImporter(fileName: todoFileName), withTitle: "From a local file")
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func importTodoItemsCompletedWithResult(result: ImportResult) {
        if (result.string != nil) {
            importTodoItemsFromString(result.string!)
        }
        
        reloadData()
        
        let title = "Hey!"
        let message = getImportMessageForResult(result)
        alertTitle(title, andMessage: message)
    }
    
    private func importTodoItemsFromString(string: String) {
        let jsonResult = JsonSerializer().deserializeString(string)
        if (jsonResult.error != nil) {
            print(jsonResult.error!.description)
        } else {
            if let arr = jsonResult.result as? [[String : AnyObject]] {
                let items = arr.map { TodoItem(dict: $0) }
                items.forEach { self.todoItemRepository.addTodoItem($0) }
            } else {
                print("Invalid data in string")
            }
        }
    }
    
    private func reloadData() {
        let items = todoItemRepository.getTodoItems()
        let photos = photoRepository.getPhotos()
        todoItemCell.detailTextLabel?.text = "\(items.count) items"
        photoAlbumCell.detailTextLabel?.text = "\(photos.count) items"
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
        case importTodoItemsCell: importTodoItems()
        case importPhotoAlbumCell:
            let title = "Coming soon"
            let message = "We are working on this"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        default: break
        }
    }
}

