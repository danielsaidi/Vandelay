//
//  DataImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is implemented by all Vandelay importers
 that can import NSData. Use data importers for objects
 that cannot be serialized to strings or JSON.
 
 */

import Foundation

public protocol DataImporter: class, Importer {
    
    func importData(completion: ImportCompletion?)
}
