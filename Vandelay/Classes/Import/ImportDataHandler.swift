//
//  ImportDataHandler.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This class must be implemented by one or more classes
 in your app, if you use the import alert class. It is
 used to handle imported data.
 
 If you only use string import, you can leave the data
 method blank, and vice versa.
 
 */

import Foundation

public protocol ImportDataHandler: class {
    
    func handleImportedData(data: NSData?)
    func handleImportedDataString(string: String?)
}
