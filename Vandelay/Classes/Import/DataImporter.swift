//
//  DataImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is implemented by all Vandelay importers
 that can be used to import NSData. Use a data importer
 when you have exported data with a data exporter.
 
 */

import Foundation

public protocol DataImporter: class {
    
    func importData(completion: ((result: ImportResult) -> ())?)
}
