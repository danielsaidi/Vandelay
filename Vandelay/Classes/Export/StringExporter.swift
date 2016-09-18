//
//  StringExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-05-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is implemented by all Vandelay exporters
 that can export strings, e.g. JSON serialized objects.
 
 */

import Foundation

public protocol StringExporter: class, Exporter {
    
    func export(_ string: String, completion: ((_ result: ExportResult) -> ())?)
}
