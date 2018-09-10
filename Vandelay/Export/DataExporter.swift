//
//  DataExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is implemented by all Vandelay exporters that
 can be used to export Data. Use them for types that can not
 be serialized, e.g. types with binary properties.
 
 */

import Foundation

public protocol DataExporter: class, Exporter {
    
    func export(data: Data, completion: @escaping ExportCompletion)
}

public extension DataExporter {
    
    public func exportData<T: Encodable>(for object: T, encoder: JSONEncoder, completion: @escaping ExportCompletion) {
        do {
            let data = try getData(for: object, using: encoder)
            export(data: data, completion: completion)
        } catch {
            let result = ExportResult(method: exportMethod, error: error)
            completion(result)
        }
    }
}
