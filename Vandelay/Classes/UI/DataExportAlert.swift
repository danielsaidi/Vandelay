//
//  DataExportAlert.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-05-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This alert controller can be used to present the user
 with a list of options for exporting data.
 
 You must set the dataProvider and completion property.
 
 */

import UIKit

public class DataExportAlert: VandelayAlert {
    
    
    // MARK: Properties
    
    public var completion: ((result: ExportResult) -> ())!
    public var dataProvider: DataProvider!
    
    
    
    // MARK: Public functions
    
    public func addExporter(exporter: DataExporter, withTitle title: String) {
        let action = UIAlertAction(title: title, style: .Default) { action in
            self.dataProvider.getExportData({ data in
                if (data == nil) {
                    let error = "DataExportAlert: The data provider did not return any data."
                    let result = exporter.getResultWithErrorMessage(error)
                    self.completion?(result: result)
                } else {
                    exporter.exportData(data!, completion: self.completion)
                }
            })
        }
        addAction(action)
    }
}