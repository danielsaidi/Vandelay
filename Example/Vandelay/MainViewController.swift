//
//  ViewController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 06/07/2016.
//  Copyright (c) 2016 Daniel Saidi. All rights reserved.
//

import UIKit
import Vandelay

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoItemRepository = TodoItemMemoryRepository()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        let items = todoItemRepository.getTodoItems()
        todoItemCell.detailTextLabel?.text = "\(items.count) items"
    }
    
    
    
    // MARK: Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "TodoSegue":
            let vc = segue.destinationViewController as! TodoViewController
            vc.repository = self.todoItemRepository
        default: break
        }
    }
    
    
    
    // MARK: Properties
    
    var todoItemRepository: TodoItemRepository!
    
    
    
    // MARK: Outlets
    
    @IBOutlet weak var photoAlbumCell: UITableViewCell!
    @IBOutlet weak var todoItemCell: UITableViewCell!
    
    
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

