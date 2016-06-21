//
//  TodoViewController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-21.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    

    // MARK: Properties
    
    var repository: TodoItemRepository?
    
    private var items = [TodoItem]()
    
    private var hasItems: Bool { return items.count > 0 }
    
    
    
    // MARK: Actions
    
    @IBAction func add() {
        let title = "Add new item"
        let message = "What do you want to remember?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler(nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            let name = alert.textFields![0].text!
            self.repository?.createTodoItemWithName(name)
            self.reloadData()
        }))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    // MARK: Private functions
    
    private func reloadData() {
        items = repository?.getTodoItems() ?? [TodoItem]()
        items = items.sort({ item1, item2 -> Bool in
            return item1.name < item2.name
        })
        tableView.reloadData()
    }
    
    
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return hasItems
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (hasItems) {
            return self.tableView(tableView, cellForItemAtIndexPath: indexPath)
        } else {
            return tableView.dequeueReusableCellWithIdentifier("NoItemsCell")!
        }
    }
    
    private func tableView(tableView: UITableView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell")!
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let item = items[indexPath.row]
            repository?.deleteTodoItem(item)
            reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (hasItems) {
            let item = items[indexPath.row]
            cell.accessoryType = item.completed ? .Checkmark : .None
        }
    }
    
    
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if (hasItems) {
            let item = items[indexPath.row]
            item.completed = !item.completed
            reloadData()
        }
    }
}
