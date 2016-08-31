//
//  StringEncoder.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-03-21.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import Foundation

public protocol StringEncoder {
    
    func decodeString(encodedString: String) -> String
    func encodeString(string: String) -> String
}
