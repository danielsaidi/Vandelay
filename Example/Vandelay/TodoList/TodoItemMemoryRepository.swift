//
//  TodoItemMemoryRepository.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-21.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Vandelay

class TodoItemMemoryRepository : TodoItemRepository {
    
    
    // MARK: Properties
    
    private var items = [TodoItem]()
    
    
    // MARK: Public functions
    
    func createTodoItemWithName(name: String) -> TodoItem {
        let item = TodoItem()
        item.id = UuidGenerator().generateUniqueId()
        item.name = name
        
        items.append(item)
        
        return item
    }
    
    func deleteTodoItem(item: TodoItem) {
        let index = items.indexOf(item)
        if (index != nil) {
            items.removeAtIndex(index!)
        }
    }
    
    func getTodoItems() -> [TodoItem] {
        return items
    }
    
    func getTodoItem(id: String) -> TodoItem? {
        return items.filter { $0.id == id }.first
    }
}
