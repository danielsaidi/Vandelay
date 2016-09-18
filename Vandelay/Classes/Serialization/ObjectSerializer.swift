//
//  ObjectSerializer.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-03-21.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol can be implemented by all classes that can
 be used to serialize and deserialize objects.
 
 */

import UIKit

public protocol ObjectSerializer {
    
    func deserialize(_ json: String) -> (result: Any?, error: NSError?)
    func serialize(_ object: Any) -> (result: String?, error: NSError?)
}
