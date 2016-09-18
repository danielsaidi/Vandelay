//
//  DataExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is implemented by all Vandelay exporters
 that can export NSData. Use data exporters for objects
 that cannot be serialized, such as objects with NSData
 properties.
 
 */

import Foundation

public protocol DataExporter: class, Exporter {
    
    func exportData(_ data: Data, completion: ((_ result: ExportResult) -> ())?)
}
