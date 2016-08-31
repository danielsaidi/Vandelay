//
//  Base64StringEncoder.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-03-21.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import Foundation

public class Base64StringEncoder: NSObject, StringEncoder {
    
    public func decodeString(encodedString: String) -> String {
        let data = NSData(base64EncodedString: encodedString, options: .IgnoreUnknownCharacters)
        let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
        return result as! String
    }
    
    public func encodeString(string: String) -> String {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding)
        let result = data?.base64EncodedStringWithOptions(.EncodingEndLineWithLineFeed)
        return result!
    }
}
