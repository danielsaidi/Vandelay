//
//  IncomingFileHandler.swift
//  VandelayDemo
//
//  Created by Daniel Saidi on 2019-10-08.
//

import UIKit
import Vandelay

/**
 This protocol lets `AppDelegate` and `SceneDelegate` share
 import logic for incoming files.
 */
protocol IncomingFileHandler {}

extension IncomingFileHandler {
    
    /**
     The root view controller, if it is a `ViewController`.
     */
    var vc: ViewController? {
        let nvc = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        return nvc?.viewControllers.first as? ViewController
    }
    
    /**
     Import the content of a url, using a `UrlImporter` that
     tries to import both photo album and todo list data.
     */
    func performImport(from url: URL) {
        let importer = UrlImporter(url: url)
        vc?.importPhotoAlbum(with: importer)
        vc?.importTodoList(with: importer)
    }
    
    /**
     Import the content of a url using the above method, but
     after a small delay, which gives the app time to start.
     */
    func performImportOnStart(from url: URL) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performImport(from: url)
        }
    }
}
