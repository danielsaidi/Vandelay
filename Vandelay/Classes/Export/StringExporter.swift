//
//  StringExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-05-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

/*
 
 This protocol is implemented by all Vandelay exporters
 that can be used to export strings, or serialized data
 such as JSON serialized objects or collections.
 
 */

public protocol StringExporter: class, Exporter {
    
    func exportString(string: String, completion: ((result: ExportResult) -> ()))
}