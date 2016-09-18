//
//  JsonObjectSerializer.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-03-21.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This serializer can be used to serialize simple objects
 to JSON strings, and vice versa. Note that objects with
 properties (as well as any sub property with properties)
 must be converted to a dictionary before the serializer
 can serialize them.
 
 */

import UIKit

public class JsonObjectSerializer: NSObject, ObjectSerializer {

    public func deserializeString(string: String) -> (result: Any?, error: NSError?) {
        do {
            guard let data = string.data(using: .utf8) else { return (nil, nil) }
            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return (result: result, error: nil)
        } catch let error as NSError {
            return (result: nil, error: error)
        }
    }
    
    public func serializeObject(object: Any) -> (result: String?, error: NSError?) {
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            let result = String(data: data, encoding: .utf8)
            return (result: result, error: nil)
        } catch let error as NSError {
            return (result: nil, error: error)
        }
    }
}
