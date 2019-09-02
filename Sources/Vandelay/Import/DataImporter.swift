//
//  DataImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is implemented by all Vandelay importers that
 can be used to import Data. Use them for types that can not
 be serialized, e.g. types with binary properties.
 
 A data importer will just read data from a supported source
 and return it in the import result. You must parse the data
 and import any importable content manually.
 
 */

import Foundation

/**
 This protocol is implemented by all Vandelay importers that
 can import binary `Data`.
 
 A data importer will just read data from a supported source
 and return it in the import result. You must parse the data
 and import any importable content manually. 
 
 Since data exports are platform-specific, only use this for
 cases when you need the power of the data format, or when a
 type can't be serialized, e.g. due to binary properties.
 */
public protocol DataImporter: Importer {
    
    func importData(completion: @escaping ImportCompletion)
}
