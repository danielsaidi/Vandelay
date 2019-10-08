//
//  DataExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol is implemented by all Vandelay exporters that
 can export binary `Data`.
 
 Since data exports are platform-specific, only use this for
 cases when you need the power of the data format, or when a
 type can't be serialized, e.g. due to binary properties.
 */
public protocol DataExporter: AnyObject, Exporter {
    
    func export(data: Data, completion: @escaping ExportCompletion)
}

public extension DataExporter {
    
    func exportData<T: Encodable>(for object: T, encoder: JSONEncoder, completion: @escaping ExportCompletion) {
        do {
            let data = try getData(for: object, using: encoder)
            export(data: data, completion: completion)
        } catch {
            let result = ExportResult(method: exportMethod, error: error)
            completion(result)
        }
    }
}
