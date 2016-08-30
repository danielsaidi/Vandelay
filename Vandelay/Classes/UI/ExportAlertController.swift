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
    func alertController(controller: ExportAlertController, didPickDataExporter exporter: DataExporter)
    func alertController(controller: ExportAlertController, didPickStringExporter exporter: StringExporter)
}


public class ExportAlertController: UIAlertController {
    
    weak public var delegate: ExportAlertControllerDelegate?
    
    
    public func addDataExporter(exporter: DataExporter, withTitle title: String) {
        let action = UIAlertAction(title: title, style: .Default) { action in
            self.delegate?.alertController(self, didPickDataExporter: exporter)
        }
        addAction(action)
    }
    
    public func addStringExporter(exporter: StringExporter, withTitle title: String) {
        let action = UIAlertAction(title: title, style: .Default) { action in
            self.delegate?.alertController(self, didPickStringExporter: exporter)
        }
        addAction(action)
    }
}