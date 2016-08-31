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

    public func deserializeString(string: String) -> (result: AnyObject?, error: NSError?) {
        do {
            let data = string.dataUsingEncoding(NSUTF8StringEncoding)
            let result = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            return (result: result, error: nil)
        } catch let error as NSError {
            return (result: nil, error: error)
        }
    }
    
    public func serializeObject(object: AnyObject) -> (result: String?, error: NSError?) {
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(object, options: .PrettyPrinted)
            let result = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
            return (result: result, error: nil)
        } catch let error as NSError {
            return (result: nil, error: error)
        }
    }
}
