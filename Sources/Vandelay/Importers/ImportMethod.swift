//
//  ImportMethod.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum specifies import methods that are currently supported by Vandelay.
 
 If you create an importer that uses a custom import method, you can use the `custom` case.
 */
public enum ImportMethod: Equatable {
    
    case
    custom(name: String),
    file,
    pasteboard,
    url
}
