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
            /*self.dataProvider.getExportData({ data in
                if (data == nil) {
                    let error = "ImportAlertController did not receive any data."
                    let result = exporter.getResultWithErrorMessage(error)
                    self.completion?(result: result)
                } else {
                    exporter.exportData(data!, completion: self.completion)
                }
            })*/
        }
        self.addAction(action)
    }
    
    public func addStringImporter(exporter: StringImporter, withTitle title: String) {
        let action = UIAlertAction(title: title, style: .Default) { action in
            /*self.dataProvider.getExportDataString({ string in
                if (string == nil) {
                    let error = "ExportAlertController did not receive a string."
                    let result = exporter.getResultWithErrorMessage(error)
                    self.completion?(result: result)
                } else {
                    exporter.exportString(string!, completion: self.completion)
                }
            })*/
        }
        self.addAction(action)
    }
}