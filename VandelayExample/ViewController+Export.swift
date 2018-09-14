//
//  ViewController+Export.swift
//  VandelayExample
//
//  Created by Daniel Saidi on 2018-09-16.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import Vandelay
import VandelayDropbox

extension ViewController {
    
    func exportPhotoAlbum() {
        let title = "Export photo album"
        let message = "How do you want to export this data?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(exportPhotoAlbumAction(for: FileExporter(fileName: photoFile), title: "To a local file"))
        alert.addAction(exportPhotoAlbumAction(for: EmailExporter(fromViewController: self, fileName: photoFile), title: "In an e-mail"))
        alert.addAction(exportPhotoAlbumAction(for: MessageExporter(fromViewController: self, fileName: photoFile), title: "In a message"))
        alert.addAction(exportPhotoAlbumAction(for: DropboxExporter(fromViewController: self, fileName: photoFile), title: "To a Dropbox file"))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func exportTodoList() {
        let title = "Export todo list"
        let message = "How do you want to export this data?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(exportTodoListAction(for: PasteboardExporter(), title: "To the pasteboard"))
        alert.addAction(exportTodoListAction(for: FileExporter(fileName: photoFile), title: "To a local file"))
        alert.addAction(exportTodoListAction(for: EmailExporter(fromViewController: self, fileName: photoFile), title: "In an e-mail"))
        alert.addAction(exportTodoListAction(for: MessageExporter(fromViewController: self, fileName: photoFile), title: "In a message"))
        alert.addAction(exportTodoListAction(for: DropboxExporter(fromViewController: self, fileName: photoFile), title: "To a Dropbox file"))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - Private Functions

private extension ViewController {
    
    func exportPhotoAlbum(with exporter: DataExporter) {
        let photos = photoRepository.getPhotos()
        exporter.exportData(for: photos, encoder: JSONEncoder()) { [weak self] (result) in
            self?.handleExportResult(result)
        }
    }
    
    func exportPhotoAlbumAction(for exporter: DataExporter, title: String) -> UIAlertAction {
        let action: (DataExporter) -> () = { [weak self] exporter in self?.exportPhotoAlbum(with: exporter)}
        return UIAlertAction(title: title, style: .default) { _ in action(exporter) }
    }
    
    func exportTodoList(with exporter: StringExporter) {
        let items = todoItemRepository.getItems()
        exporter.exportString(for: items, encoder: JSONEncoder()) { [weak self] (result) in
            self?.handleExportResult(result)
        }
    }
    
    func exportTodoListAction(for exporter: StringExporter, title: String) -> UIAlertAction {
        let action: (StringExporter) -> () = { [weak self] exporter in self?.exportTodoList(with: exporter)}
        return UIAlertAction(title: title, style: .default) { _ in action(exporter) }
    }
}
