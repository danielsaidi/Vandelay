//
//  TodoItemRepository.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-21.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Vandelay

class TodoItemRepository {
    
    
    // MARK: - Properties
    
    private var items = [String: TodoItem]()
    
    
    // MARK: - Public functions
    
    func add(_ item: TodoItem) {
        items[item.id] = item
    }
    
    func add(_ items: [TodoItem]) {
        items.forEach { add($0) }
    }
    
    func delete(_ item: TodoItem) {
        items.removeValue(forKey: item.id)
    }
    
    func getItems() -> [TodoItem] {
        return items.values.sorted { $0.name < $1.name }
    }
    
    func getItem(withId id: String) -> TodoItem? {
        return items[id]
    }
}
