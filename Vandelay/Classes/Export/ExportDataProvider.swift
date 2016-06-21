//
//  ExportDataProvider.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-05-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This class must be implemented by one or more classes
 in your app, if you use the export alert class. It is
 used to provide Vandelay exporters with data.
 
 If you only use string export, you can leave the data
 method blank, and vice versa.
 
 */

import Foundation

public protocol ExportDataProvider: class {
    
    func getExportData(completion: ((data: NSData?) -> ()))
    func getExportDataString(completion: ((string: String?) -> ()))
}
