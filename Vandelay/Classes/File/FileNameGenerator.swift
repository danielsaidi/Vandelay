//
//  FileNameGenerator.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-04.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is implemented by all classes that can be
 used to generate file names.
 
 */

import Foundation

public protocol FileNameGenerator {
    
    func getFileName() -> String
}
