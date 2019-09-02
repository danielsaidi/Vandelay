//
//  Exporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-02.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol is inherited by the string and data exporters.
 It has no logic, besides specifying an export method and to
 provide encoding utilities.
 */
public protocol Exporter {
    
    var exportMethod: ExportMethod { get }
}

public typealias ExportCompletion = (_ result: ExportResult) -> ()

public extension Exporter {
    
    func getData<T: Encodable>(for object: T, using encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        try encoder.encode(object)
    }
    
    func getString<T: Encodable>(for object: T, using encoder: JSONEncoder = JSONEncoder()) throws -> String {
        let data = try getData(for: object, using: encoder)
        return String(data: data, encoding: .utf8)!
    }
}
