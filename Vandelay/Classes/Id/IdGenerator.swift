//
//  IdGenerator.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2014-12-19.
//  Copyright (c) 2014 Daniel Saidi. All rights reserved.
//

import Foundation

public protocol IdGenerator {
    
    func generateUniqueId() -> String
}
