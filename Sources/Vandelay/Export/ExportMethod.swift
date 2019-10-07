//
//  ExportMethod.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2018-09-11.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum specifies export methods that are currently supported by Vandelay.
 
 If you create an exporter that uses a custom export method, you can use the `custom` case.
 */
public enum ExportMethod: Equatable {
    
    case
    custom(name: String),
    email,
    file,
    message,
    pasteboard
}
