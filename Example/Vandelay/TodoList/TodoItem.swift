//
//  TodoItem.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-20.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This class only has properties that can be serialized
 to string and can therefore be exported with a simple
 string exporter.
 
 */

import UIKit
import Vandelay

class TodoItem: NSObject {

    
    // MARK: - Initialization
    
    init(name: String) {
        id = UuidGenerator().generateUniqueId()
        self.name = name
        completed = false
        super.init()
    }
    
    required init(dict: [String : Any]) {
        id = dict["id"] as? String ?? ""
        name = dict["name"] as? String ?? ""
        completed = dict["completed"] as? Bool ?? false
        super.init()
    }
    
    
    
    // MARK: - Properties
    
    var id: String
    var name: String
    var completed: Bool
    
    
    
    // MARK: - Public functions
    
    func toDictionary() -> [String : Any] {
        var dict = [String : Any]()
        dict["id"] = id
        dict["name"] = name
        dict["completed"] = completed
        return dict
    }
}
