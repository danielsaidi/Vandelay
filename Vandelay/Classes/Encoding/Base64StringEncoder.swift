//
//  Base64StringEncoder.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-03-21.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import Foundation

public class Base64StringEncoder: NSObject, StringEncoder {
    
    public func decode(string: String) -> String? {
        let data = Data(base64Encoded: string, options: .ignoreUnknownCharacters)
        return String(data: data!, encoding: .utf8)
    }
    
    public func encode(string: String) -> String? {
        let data = string.data(using: .utf8)
        let encoded = data?.base64EncodedData(options: .endLineWithLineFeed)
        guard encoded != nil else { return nil }
        return String(data: encoded!, encoding: .utf8)
    }
}
