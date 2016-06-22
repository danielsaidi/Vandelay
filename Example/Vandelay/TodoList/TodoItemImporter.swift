//
//  TodoItemImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This class will handle todo item imports in this demo
 app. While you do not have to have separate importers
 to use Vandelay, it is strongly recommended, since it
 will help you organize your code.
 
 The class implements Importer only to get access to a
 help method from the extension class. It's bad design,
 but hey...who cares?
 
 */

import UIKit
import Vandelay

class TodoItemImporter: NSObject, Importer {
    
    
    // MARK: Initialization
    
    init(repository: TodoItemRepository) {
        self.repository = repository
        super.init()
    }
    
    
    
    // MARK: Properties
    
    var importCompletion: ((result: ImportResult) -> ())?
    var importMethod: String? { return "Main Importer" }
    
    var repository: TodoItemRepository
    
    
    
    // MARK: Public functions
    
    func importTodoItemsWithCompletion(completion: ((result: ImportResult) -> ())?) {
        self.importCompletion = completion
        
        let title = "Import Todo List items"
        let message = "How do you want to import todo list items?"
        let alert = ImportAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alert.completion = importCompletedWithResult
        alert.addStringImporter(PasteboardImporter(), withTitle: "From the pasteboard")
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        getTopmostViewController()!.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    // MARK: Private functions
    
    private func getImportMessageForResult(result: ImportResult) -> String {
        switch result.state {
        case .Cancelled:
            return "Your import was cancelled."
        case .Completed:
            return "Your data was imported, using the \"\(result.importMethod!)\" method"
        case .Failed:
            return "Your import failed with error \(result.error?.description)."
        case .InProgress:
            return "Your import is in progress. Please wait."
        }
    }
    
    private func importCompletedWithResult(result: ImportResult) {
        let title = "Hey!"
        let message = getImportMessageForResult(result)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        getTopmostViewController()!.presentViewController(alert, animated: true, completion: nil)
        
        if (result.string != nil) {
            importItemsFromString(result.string!)
        }
        
        importCompletion?(result: result)
    }
    
    private func importItemsFromString(string: String) {
        let jsonResult = JsonSerializer().deserializeString(string)
        if (jsonResult.error != nil) {
            print(jsonResult.error!.description)
        } else {
            if let arr = jsonResult.result as? [[String : AnyObject]] {
                let items = arr.map { TodoItem(dict: $0) }
                items.forEach { self.repository.addTodoItem($0) }
            } else {
                print("Invalid data in string")
            }
        }
    }
}
