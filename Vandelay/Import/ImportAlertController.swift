//
//  DataImportAlertController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-08-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This alert controller can be used to present the user
 with options for importing data.
 
 Add one or several importers with addDataImporter and
 addStringImporter functions, then set the delegate to
 detect when the user selects an importer.
 
 */

import UIKit


public protocol ImportAlertControllerDelegate: class {
    func alert(_ alert: ImportAlertController, didPickDataImporter importer: DataImporter)
    func alert(_ alert: ImportAlertController, didPickStringImporter importer: StringImporter)
}


open class ImportAlertController: UIAlertController {
    
    weak public var delegate: ImportAlertControllerDelegate?
    
    
    open func add(dataImporter importer: DataImporter, withTitle title: String) {
        let action = UIAlertAction(title: title, style: .default) { _ in
            self.delegate?.alert(self, didPickDataImporter: importer)
        }
        addAction(action)
    }
    
    open func add(stringImporter importer: StringImporter, withTitle title: String) {
        let action = UIAlertAction(title: title, style: .default) { _ in
            self.delegate?.alert(self, didPickStringImporter: importer)
        }
        addAction(action)
    }
}
