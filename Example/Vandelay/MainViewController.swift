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
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: UIImage(named: "NavBarLogo"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    
    
    // MARK: - Properties
    
    let photoFileName = "photoAlbum.vandelay"
    let todoFileName = "todoList.vandelay"
    
    var todoItemRepository = TodoItemRepository()
    var photoRepository = PhotoRepository()
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var exportPhotoAlbumCell: UITableViewCell!
    @IBOutlet weak var exportTodoItemsCell: UITableViewCell!
    @IBOutlet weak var importPhotoAlbumCell: UITableViewCell!
    @IBOutlet weak var importTodoItemsCell: UITableViewCell!
    @IBOutlet weak var photoAlbumCell: UITableViewCell!
    @IBOutlet weak var todoItemCell: UITableViewCell!
    
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "PhotoSegue":
            let vc = segue.destination as! PhotoViewController
            vc.repository = photoRepository
        case "TodoSegue":
            let vc = segue.destination as! TodoItemViewController
            vc.repository = todoItemRepository
        default: break
        }
    }
    
    
    
    // MARK: - Export functions
    
    private func exportMessage(for result: ExportResult) -> String {
        if (result.filePath != nil) {
            return "Your data was exported to \(result.filePath!)"
        }
        
        switch result.state {
        case .cancelled: return "Your export was cancelled."
        case .completed: return "Your data was exported, using the \"\(result.exportMethod)\" method"
        case .failed: return "Your export failed with error \(result.error?.description ?? "N/A")."
        case .inProgress: return "Your export is in progress. Please wait."
        }
    }
    
    private func exportPhotoAlbum() {
        let title = "Export Photo Album"
        let message = "How do you want to export this album?"
        let alert = ExportAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.delegate = self
        alert.addDataExporter(FileExporter(fileName: photoFileName), withTitle: "To a local file")
        alert.addDataExporter(DropboxExporter(fileName: photoFileName), withTitle: "To a Dropbox file")
        alert.addDataExporter(EmailExporter(fileName: photoFileName), withTitle: "As an e-mail attachment")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func exportPhotoAlbum(with exporter: DataExporter) {
        let photos = photoRepository.getPhotos()
        let data = NSKeyedArchiver.archivedData(withRootObject: photos)
        exporter.exportData(data) { result in
            self.exportCompleted(withResult: result)
        }
    }
    
    private func exportTodoList() {
        let title = "Export Todo List"
        let message = "How do you want to export this list?"
        let alert = ExportAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.delegate = self
        alert.addStringExporter(PasteboardExporter(), withTitle: "To the pasteboard")
        alert.addStringExporter(FileExporter(fileName: todoFileName), withTitle: "To a local file")
        alert.addStringExporter(DropboxExporter(fileName: todoFileName), withTitle: "To a Dropbox file")
        alert.addStringExporter(EmailExporter(fileName: todoFileName), withTitle: "As an e-mail attachment")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func exportTodoList(with exporter: StringExporter) {
        let items = todoItemRepository.getTodoItems()
        let dicts = items.map { $0.toDictionary() }
        let json = JsonObjectSerializer().serialize(dicts).result
        exporter.exportString(json!) { result in
            self.exportCompleted(withResult: result)
        }
    }
    
    private func exportCompleted(withResult result: ExportResult) {
        let success = result.error == nil
        let title = success ? "Yeah!" : "Error!"
        let message = success ? exportMessage(for: result) : result.error!.localizedDescription
        alert(title: title, message: message)
    }

    
    
    
    // MARK: - Import functions
    
    private func importMessage(for result: ImportResult) -> String {
        switch result.state {
        case .cancelled: return "Your import was cancelled."
        case .completed: return "Your data was imported, using the \"\(result.importMethod)\" method"
        case .failed: return "Your import failed with error \(result.error?.description ?? "N/A")."
        case .inProgress: return "Your import is in progress. Please wait."
        }
    }
    
    private func importPhotoAlbum() {
        let title = "Import Photo Album"
        let message = "How do you want to import photos?"
        let alert = ImportAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.delegate = self
        alert.addDataImporter(FileImporter(fileName: photoFileName), withTitle: "From a local file")
        alert.addDataImporter(DropboxImporter(fileName: photoFileName), withTitle: "From a Dropbox file")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func importPhotoAlbum(with importer: DataImporter) {
        importer.importData { result in
            guard self.verifyImportResult(result) else { return }
            guard let data = result.data else { return }
            guard let photos = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Photo] else {
                self.alert(title: "Error", message: "Invalid import data")
                return
            }
            photos.forEach { self.photoRepository.addPhoto(photo: $0) }
            self.reloadData()
            self.alert(title: "Hey!", message: self.importMessage(for: result))
        }
    }
    
    private func importTodoList() {
        let title = "Import Todo List"
        let message = "How do you want to import?"
        let alert = ImportAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.delegate = self
        alert.addStringImporter(PasteboardImporter(), withTitle: "From the pasteboard")
        alert.addStringImporter(FileImporter(fileName: todoFileName), withTitle: "From a local file")
        alert.addStringImporter(DropboxImporter(fileName: todoFileName), withTitle: "From a Dropbox file")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func importTodoList(with importer: StringImporter) {
        importer.importString { result in
            guard self.verifyImportResult(result) else {
                return
            }
            
            guard let string = result.string else {
                self.alert(title: "Error", message: "No string to import")
                return
            }
            
            let jsonResult = JsonObjectSerializer().deserialize(string)
            guard let dict = jsonResult.result as? [[String : Any]] else {
                self.alert(title: "Error", message: "Invalid import json")
                return
            }
            
            let items = dict.map { TodoItem(dict: $0) }
            items.forEach { self.todoItemRepository.addTodoItem(item: $0) }
            self.reloadData()
            self.alert(title: "Hey!", message: self.importMessage(for: result))
        }
    }
    
    private func verifyImportResult(_ result: ImportResult) -> Bool {
        let inProgress = result.state == .inProgress
        let hasError = result.error != nil
        let success = !inProgress && !hasError
        if (success) {
            return true
        }
        
        let title = hasError ? "Import error" : "Import began"
        let message = hasError ? result.error!.localizedDescription : "Your import has begun. Please wait."
        self.alert(title: title, message: message)
        return false
    }

    
    
    // MARK: - Private functions
    
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func reloadData() {
        let items = todoItemRepository.getTodoItems()
        let photos = photoRepository.getPhotos()
        todoItemCell.detailTextLabel?.text = "\(items.count) items"
        photoAlbumCell.detailTextLabel?.text = "\(photos.count) photos"
    }
    
    
    
    // MARK: - ExportAlertControllerDelegate
    
    func alert(_ alert: ExportAlertController, didPick exporter: DataExporter) {
        exportPhotoAlbum(with: exporter)
    }
    
    func alert(_ alert: ExportAlertController, didPick exporter: StringExporter) {
        exportTodoList(with: exporter)
    }
    
    
    
    // MARK: - ImportAlertControllerDelegate
    
    func alert(_ alert: ImportAlertController, didPick importer: DataImporter) {
        importPhotoAlbum(with: importer)
    }
    
    func alert(_ alert: ImportAlertController, didPick importer: StringImporter) {
        importTodoList(with: importer)
    }
    
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ view: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView(view, cellForRowAt: indexPath)
        switch cell {
        case exportPhotoAlbumCell: exportPhotoAlbum()
        case exportTodoItemsCell: exportTodoList()
        case importTodoItemsCell: importTodoList()
        case importPhotoAlbumCell: importPhotoAlbum()
        default: break
        }
    }
}

