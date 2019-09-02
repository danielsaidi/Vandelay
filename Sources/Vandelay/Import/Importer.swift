//
//  Importer.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol is inherited by the string and data importers.
 It has no logic, besides specifying an import method.
 */
public protocol Importer {
    
    var importMethod: ImportMethod { get }
}

public typealias ImportCompletion = (_ result: ImportResult) -> ()
