//
//  StringImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is implemented by all Vandelay importers
 that can import strings, e.g. JSON serialized objects.
 
 */

import Foundation

public protocol StringImporter: class, Importer {
    
    func importString(completion: ((result: ImportResult) -> ())?)
}
