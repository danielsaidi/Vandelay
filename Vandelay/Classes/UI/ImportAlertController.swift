//
//  ImportAlertController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This alert controller can be used to easily display a
 list of import options to the user of the app.
 
 When using this alert class, you must remember to set
 the completion property. If you do not, the class can
 not notify you with info on how the import is going.
 
 */


import UIKit

public class ImportAlertController: UIAlertController {
    
    
    // MARK: Properties
    
    public var completion: ((result: ImportResult) -> ())?
    
    
    
    // MARK: Public functions
    
    public func addDataImporter(importer: DataImporter, withTitle title: String) {
        let action = UIAlertAction(title: title, style: .Default) { action in
            importer.importData({ result in
                self.completion?(result: result)
            })
        }
        self.addAction(action)
    }
    
    public func addStringImporter(importer: StringImporter, withTitle title: String) {
        let action = UIAlertAction(title: title, style: .Default) { action in
            importer.importString({ result in
                self.completion?(result: result)
            })
        }
        self.addAction(action)
    }
}