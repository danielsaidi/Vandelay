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
        navigationItem.titleView = UIImageView(image: UIImage(named: "NavBarLogo"))
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
        alert.addDataExporter(FileExporter(fileName: photoFileName), withTitle: "To a local file")
        alert.addDataExporter(DropboxExporter(fileName: photoFileName), withTitle: "To a Dropbox file")
        alert.addStringExporter(EmailExporter(fileName: photoFileName), withTitle: "As an e-mail attachment")
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func exportTodoList() {
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
    
    private func importPhotoAlbum() {
        let title = "Import Photo Album"
        let message = "How do you want to import?"
        let alert = ImportAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alert.completion = importPhotoAlbumCompletedWithResult
        alert.addDataImporter(FileImporter(fileName: photoFileName), withTitle: "From a local file")
        alert.addDataImporter(DropboxImporter(fileName: photoFileName), withTitle: "From a Dropbox file")
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func importPhotoAlbumCompletedWithResult(result: ImportResult) {
        if let data = result.data {
            let obj = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            if let photos = obj as? [Photo] {
                photos.forEach { self.photoRepository.addPhoto($0) }
                reloadData()
            } else {
                alertTitle("Error", andMessage: "Invalid data")
                return
            }
        }
        
        alertTitle("Hey!", andMessage: getImportMessageForResult(result))
    }
    
    private func importTodoList() {
        let title = "Import Todo List"
        let message = "How do you want to import?"
        let alert = ImportAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alert.completion = importTodoListCompletedWithResult
        alert.addStringImporter(PasteboardImporter(), withTitle: "From the pasteboard")
        alert.addStringImporter(FileImporter(fileName: todoFileName), withTitle: "From a local file")
        alert.addStringImporter(DropboxImporter(fileName: todoFileName), withTitle: "From a Dropbox file")
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func importTodoListCompletedWithResult(result: ImportResult) {
        if let string = result.string {
            let jsonResult = JsonSerializer().deserializeString(string)
            if (jsonResult.error != nil) {
                alertTitle("Error", andMessage: "Could not parse Todo List JSON")
                return
            }
            
            if let arr = jsonResult.result as? [[String : AnyObject]] {
                let items = arr.map { TodoItem(dict: $0) }
                items.forEach { self.todoItemRepository.addTodoItem($0) }
                reloadData()
            } else {
                alertTitle("Error", andMessage: "Invalid data in JSON")
                return
            }
        }
        
        alertTitle("Hey!", andMessage: getImportMessageForResult(result))
    }
    
    private func reloadData() {
        let items = todoItemRepository.getTodoItems()
        let photos = photoRepository.getPhotos()
        todoItemCell.detailTextLabel?.text = "\(items.count) items"
        photoAlbumCell.detailTextLabel?.text = "\(photos.count) photos"
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
        case exportTodoItemsCell: exportTodoList()
        case importTodoItemsCell: importTodoList()
        case importPhotoAlbumCell: importPhotoAlbum()
        default: break
        }
    }
}

