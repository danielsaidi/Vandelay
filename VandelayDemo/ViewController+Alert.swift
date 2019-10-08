//
//  ViewController+Alert.swift
//  VandelayDemo
//
//  Created by Daniel Saidi on 2019-10-08.
//

import Vandelay
import UIKit

extension ViewController {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func alertExportResult(_ result: ExportResult) {
        alert(title: "Done", message: result.alertMessage)
    }
    
    func alertImportResult(_ result: ImportResult) {
        alert(title: "Done", message: result.alertMessage)
    }
}
