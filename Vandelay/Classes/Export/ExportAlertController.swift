//
//  DataExportAlertController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-08-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This alert controller can be used to present the user
 with options for exporting data.
 
 Add one or several exporters with addDataExporter and
 addStringExporter functions, then set the delegate to
 detect when the user selects an exporter.
 
 */

import UIKit


public protocol ExportAlertControllerDelegate: class {
    func alert(_ alert: ExportAlertController, didPick exporter: DataExporter)
    func alert(_ alert: ExportAlertController, didPick exporter: StringExporter)
}


open class ExportAlertController: UIAlertController {
    
    weak public var delegate: ExportAlertControllerDelegate?
    
    
    open func add(dataExporter exporter: DataExporter, withTitle title: String) {
        let action = UIAlertAction(title: title, style: .default) { action in
            self.delegate?.alert(self, didPick: exporter)
        }
        addAction(action)
    }
    
    open func add(stringExporter exporter: StringExporter, withTitle title: String) {
        let action = UIAlertAction(title: title, style: .default) { action in
            self.delegate?.alert(self, didPick: exporter)
        }
        addAction(action)
    }
}
