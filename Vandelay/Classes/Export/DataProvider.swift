//
//  DataProvider.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-08-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is to be implemented by an app-specific
 class that can provide Vandelay with exportable data.
 
 */

import Foundation

public protocol DataProvider: class {
    
    func getExportData(completion: ((data: NSData?) -> ()))
}
