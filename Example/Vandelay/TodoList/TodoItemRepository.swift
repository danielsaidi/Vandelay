//
//  TodoItemRepository.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-21.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

protocol TodoItemRepository {
    func createTodoItemWithName(name: String) -> TodoItem
    func deleteTodoItem(item: TodoItem)
    func getTodoItems() -> [TodoItem]
    func getTodoItem(id: String) -> TodoItem?
}