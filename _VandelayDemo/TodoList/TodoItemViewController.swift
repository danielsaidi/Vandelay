//
//  TodoItemViewController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-21.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

class TodoItemViewController: UITableViewController {
    
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    

    // MARK: - Properties
    
    var repository: TodoItemRepository!
    
    private var hasItems: Bool { return items.count > 0 }
    private var items = [TodoItem]()
    
    
    // MARK: - Actions
    
    @IBAction func add() {
        let title = "Add todo"
        let message = "Enter todo description"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            let item = TodoItem(name: alert.textFields![0].text!)
            self.repository.add(item)
            self.reloadData()
        })
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - Private Functions

private extension TodoItemViewController {
    
    func reloadData() {
        items = repository.getItems()
        tableView.reloadData()
    }
}


// MARK: - UITableViewDataSource

extension TodoItemViewController {
    
    override func numberOfSections(in view: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ view: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(items.count, 1)
    }
    
    override func tableView(_ view: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return hasItems
    }
    
    override func tableView(_ view: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if hasItems {
            return tableView(view, cellForItemAt: indexPath)
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "NoItemsCell")!
        }
    }
    
    private func tableView(_ view: UITableView, cellForItemAt indexPath: IndexPath) -> UITableViewCell {
        let cell = view.dequeueReusableCell(withIdentifier: "ItemCell")!
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    override func tableView(_ view: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let item = items[indexPath.row]
        repository.delete(item)
        reloadData()
    }
    
    override func tableView(_ view: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard hasItems else { return }
        let item = items[indexPath.row]
        cell.accessoryType = item.completed ? .checkmark : .none
    }
}


// MARK: - UITableViewDelegate

extension TodoItemViewController {
    
    override func tableView(_ view: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.deselectRow(at: indexPath, animated: true)
        guard hasItems else { return }
        var item = items[indexPath.row]
        item.completed = !item.completed
        reloadData()
    }
}
