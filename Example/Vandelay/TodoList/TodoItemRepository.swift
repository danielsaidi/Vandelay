//
//  TodoItemRepository.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-21.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit
import Vandelay

class TodoItemRepository : NSObject {
    
    
    // MARK: - Properties
    
    private var items = [String : TodoItem]()
    
    
    // MARK: - Public functions
    
    func addTodoItem(_ item: TodoItem) {
        items[item.id] = item
    }
    
    func deleteTodoItem(_ item: TodoItem) {
        items.removeValue(forKey: item.id)
    }
    
    func getTodoItems() -> [TodoItem] {
        return items.values.sorted(by: { item1, item2 -> Bool in
            item1.name < item2.name
        })
    }
    
    func getTodoItem(id: String) -> TodoItem? {
        return items[id]
    }
}
