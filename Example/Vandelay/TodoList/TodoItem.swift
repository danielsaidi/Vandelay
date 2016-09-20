//
//  TodoItem.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-20.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This class contains serializable properties only, and
 will therefore be able to export with a simple string
 exporter.
 
 To avoid adding any third party libraries, this class
 uses really simple dictionary conversion. This allows
 us to serialize and deserialize to and from JSON with
 the basic JSON serializer that comes with Vandelay.
 
 */

import UIKit
import Vandelay

class TodoItem: NSObject {

    
    // MARK: - Initialization
    
    init(name: String) {
        super.init()
        id = UuidGenerator().generateUniqueId()
        self.name = name
    }
    
    required init(dict: [String : AnyObject]) {
        super.init()
        id = dict["id"] as? String ?? id
        name = dict["name"] as? String ?? name
        completed = dict["completed"] as? Bool ?? false
    }
    
    
    
    // MARK: - Properties
    
    var id = ""
    var name = ""
    var completed = false
    
    
    
    // MARK: - Public functions
    
    func toDictionary() -> [String : Any] {
        var dict = [String : Any]()
        dict["id"] = id
        dict["name"] = name
        dict["completed"] = completed
        return dict
    }
}
