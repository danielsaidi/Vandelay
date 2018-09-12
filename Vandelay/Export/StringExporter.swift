//
//  StringExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-05-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is implemented by all Vandelay exporters that
 can export strings, e.g. JSON serialized objects.
 
 */

import Foundation

public protocol StringExporter: Exporter {
    
    func export(string: String, completion: @escaping ExportCompletion)
}

public extension StringExporter {
    
    public func exportString<T: Encodable>(for object: T, encoder: JSONEncoder, completion: @escaping ExportCompletion) {
        do {
            let string = try getString(for: object, using: encoder)
            export(string: string, completion: completion)
        } catch {
            let result = ExportResult(method: exportMethod, error: error)
            completion(result)
        }
    }
}
