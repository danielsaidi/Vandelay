//
//  PasteboardImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This importer can import strings from the system pasteboard.
 
 */

import UIKit

public class PasteboardImporter: StringImporter {
    
    
    // MARK: - Initialization
    
    public init() {}
    
    
    // MARK: - Properties
    
    public let importMethod = ImportMethod.pasteboard
    
    
    // MARK: - StringImporter
    
    public func importString(completion: @escaping ImportCompletion) {
        guard let string = UIPasteboard.general.string else {
            let result = ImportResult(method: importMethod, state: .failed)
            return completion(result)
        }
        let result = ImportResult(method: importMethod, string: string)
        completion(result)
    }
}
