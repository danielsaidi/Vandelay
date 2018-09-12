//
//  Importer.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is inherited by the other importer protocols.
 It has no logic besides specifying an import method.
 
 */

import Foundation

public protocol Importer {
    
    var importMethod: ImportMethod { get }
}
