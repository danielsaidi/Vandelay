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

    public func deserialize(_ json: String) -> (result: Any?, error: NSError?) {
        do {
            guard let data = json.data(using: .utf8) else { return getResult(withErrorMessage: "InvalidData") }
            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return (result: result, error: nil)
        } catch let error as NSError {
            return (result: nil, error: error)
        }
    }
    
    public func serialize(_ object: Any) -> (result: String?, error: NSError?) {
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            let result = String(data: data, encoding: .utf8)
            return (result: result, error: nil)
        } catch let error as NSError {
            return (result: nil, error: error)
        }
    }
    
    
    private func getResult(withErrorMessage message: String) -> (result: Any?, error: NSError?) {
        let domain = "Vandelay"
        let userInfo = ["Description" : message]
        let error = NSError(domain: domain, code: -1, userInfo: userInfo)
        return (result: nil, error: error)
    }
}
