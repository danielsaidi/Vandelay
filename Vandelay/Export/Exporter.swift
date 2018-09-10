//
//  Exporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-02.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol gives Vandelay exporters access to core
 export functionality. It should not be implemented by
 classes outside of Vandelay.
 
 */

import UIKit

public protocol Exporter {
    
    var exportMethod: ExportMethod { get }
}


extension Exporter {
    
    func getData<T: Encodable>(for object: T, using encoder: JSONEncoder) throws -> Data {
        return try encoder.encode(object)
    }
    
    func getString<T: Encodable>(for object: T, using encoder: JSONEncoder) throws -> String {
        let data = try getData(for: object, using: encoder)
        return String(data: data, encoding: .utf8)!
    }
}
