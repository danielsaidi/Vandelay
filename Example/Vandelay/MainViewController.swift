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

class MainViewController: UITableViewController, ExportAlertControllerDelegate, ImportAlertControllerDelegate {

    
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
    
    private func reloadData() {
        let items = todoItemRepository.getTodoItems()
        let photos = photoRepository.getPhotos()
        todoItemCell.detailTextLabel?.text = "\(items.count) items"
        photoAlbumCell.detailTextLabel?.text = "\(photos.count) photos"
    }
    
    
    
    // MARK: Export functions
    
    private func exportCompletedWithResult(result: ExportResult) {
        if (result.state == .InProgress) {
            return
        }
        
        if (result.error != nil) {
            self.alertTitle("Export error", andMessage: result.error!.localizedDescription)
            return
        }

        alertTitle("Hey!", andMessage: exportMessageForResult(result))
    }
    
    private func exportMessageForResult(result: ExportResult) -> String {
        if (result.filePath != nil) {
            return "Your data was exported to \(result.filePath!)"
        }
        
        switch result.state {
        case .Cancelled:
            return "Your export was cancelled."
        case .Completed:
            return "Your data was exported, using the \"\(result.exportMethod)\" method"
        case .Failed:
            return "Your export failed with error \(result.error?.description ?? "N/A")."
        case .InProgress:
            return "Your export is in progress. Please wait."
        }
    }
    
    private func exportPhotoAlbum() {
        let title = "Export Photo Album"
        let message = "How do you want to export this album?"
        let alert = ExportAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alert.delegate = self
        alert.addDataExporter(FileExporter(fileName: photoFileName), withTitle: "To a local file")
        alert.addDataExporter(DropboxExporter(fileName: photoFileName), withTitle: "To a Dropbox file")
        alert.addDataExporter(EmailExporter(fileName: photoFileName), withTitle: "As an e-mail attachment")
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func exportPhotoAlbumWithExporter(exporter: DataExporter) {
        let photos = photoRepository.getPhotos()
        let data = NSKeyedArchiver.archivedDataWithRootObject(photos)
        exporter.exportData(data) { result in
            self.exportCompletedWithResult(result)
        }
    }
    
    private func exportTodoList() {
        let title = "Export Todo List"
        let message = "How do you want to export this list?"
        let alert = ExportAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alert.delegate = self
        alert.addStringExporter(PasteboardExporter(), withTitle: "To the pasteboard")
        alert.addStringExporter(FileExporter(fileName: todoFileName), withTitle: "To a local file")
        alert.addStringExporter(DropboxExporter(fileName: todoFileName), withTitle: "To a Dropbox file")
        alert.addStringExporter(EmailExporter(fileName: todoFileName), withTitle: "As an e-mail attachment")
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func exportTodoListWithExporter(exporter: StringExporter) {
        let items = todoItemRepository.getTodoItems()
        let dicts = items.map { $0.toDictionary() }
        let json = JsonObjectSerializer().serializeObject(dicts).result
        exporter.exportString(json!) { result in
            self.exportCompletedWithResult(result)
        }
    }
    
    
    
    // MARK: Import functions
    
    private func importMessageForResult(result: ImportResult) -> String {
        switch result.state {
        case .Cancelled:
            return "Your import was cancelled."
        case .Completed:
            return "Your data was imported, using the \"\(result.importMethod)\" method"
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
        alert.delegate = self
        alert.addDataImporter(FileImporter(fileName: photoFileName), withTitle: "From a local file")
        alert.addDataImporter(DropboxImporter(fileName: photoFileName), withTitle: "From a Dropbox file")
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func importPhotoAlbumWithImporter(importer: DataImporter) {
        importer.importData { result in
            if (!self.verifyImportResult(result)) {
                return
            }
            
            if let data = result.data {
                let obj = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                if let photos = obj as? [Photo] {
                    photos.forEach { self.photoRepository.addPhoto($0) }
                    self.reloadData()
                } else {
                    self.alertTitle("Error", andMessage: "Invalid data")
                    return
                }
            }
            
            self.alertTitle("Hey!", andMessage: self.importMessageForResult(result))
        }
    }
    
    private func importTodoList() {
        let title = "Import Todo List"
        let message = "How do you want to import?"
        let alert = ImportAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alert.delegate = self
        alert.addStringImporter(PasteboardImporter(), withTitle: "From the pasteboard")
        alert.addStringImporter(FileImporter(fileName: todoFileName), withTitle: "From a local file")
        alert.addStringImporter(DropboxImporter(fileName: todoFileName), withTitle: "From a Dropbox file")
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func importTodoListWithImporter(importer: StringImporter) {
        importer.importString { result in
            if (!self.verifyImportResult(result)) {
                return
            }
            
            if let string = result.string {
                let jsonResult = JsonObjectSerializer().deserializeString(string)
                if (jsonResult.error != nil) {
                    self.alertTitle("Error", andMessage: "Could not parse JSON")
                    return
                }
                
                if let arr = jsonResult.result as? [[String : AnyObject]] {
                    let items = arr.map { TodoItem(dict: $0) }
                    items.forEach { self.todoItemRepository.addTodoItem($0) }
                    self.reloadData()
                } else {
                    self.alertTitle("Error", andMessage: "Invalid data in JSON")
                    return
                }
            }
            
            self.alertTitle("Hey!", andMessage: self.importMessageForResult(result))
        }
    }
    
    private func verifyImportResult(result: ImportResult) -> Bool {
        if (result.state == .InProgress) {
            return false
        }
        
        if (result.error != nil) {
            self.alertTitle("Import error", andMessage: result.error!.localizedDescription)
            return false
        }
        
        return true
    }
    
    
    
    // MARK: ExportAlertControllerDelegate
    
    func alertController(controller: ExportAlertController, didPickDataExporter exporter: DataExporter) {
        exportPhotoAlbumWithExporter(exporter)
    }
    
    func alertController(controller: ExportAlertController, didPickStringExporter exporter: StringExporter) {
        exportTodoListWithExporter(exporter)
    }
    
    
    
    // MARK: ImportAlertControllerDelegate
    
    func alertController(controller: ImportAlertController, didPickDataImporter importer: DataImporter) {
        importPhotoAlbumWithImporter(importer)
    }
    
    func alertController(controller: ImportAlertController, didPickStringImporter importer: StringImporter) {
        importTodoListWithImporter(importer)
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

