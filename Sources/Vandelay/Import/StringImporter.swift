//
//  StringImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol is implemented by all Vandelay exporters that
 can import strings, e.g. JSON serialized objects.
 
 A string importer will just read strings from its supported
 source, then return it in the import result. You must parse
 the string and import any importable content manually.
 */
public protocol StringImporter: Importer {
    
    func importString(completion: @escaping ImportCompletion)
}
