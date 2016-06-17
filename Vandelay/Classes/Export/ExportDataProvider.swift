//
//  ExportDataProvider.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-05-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

/*
 
 This class must be implemented by one or more classes
 in your app. It is used to provide Vandelay exporters
 with data. 
 
 If you only use string export, you can leave the data
 method blank. If you only use data export, you can do
 the same for the string method.
 
 */

public protocol ExportDataProvider: class {
    
    func getExportData(completion: ((data: NSData?) -> ()))
    func getExportDataString(completion: ((string: String?) -> ()))
}
