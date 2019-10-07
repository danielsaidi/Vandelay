//
//  TodoItem.swift
//  VandelayDemo
//
//  Created by Daniel Saidi on 2016-06-20.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit
import Vandelay

struct TodoItem: Codable {

    
    // MARK: - Initialization
    
    init(name: String) {
        id = NSUUID().uuidString
        self.name = name
        completed = false
    }
    
    
    // MARK: - Properties
    
    let id: String
    let name: String
    var completed: Bool
}
