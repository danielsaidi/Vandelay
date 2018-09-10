//
//  PasteboardImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This importer can import strings from the pasteboard.
 
 */

import UIKit

public class PasteboardImporter: NSObject, StringImporter {

    public private(set) var importMethod = "Pasteboard"
    
    public func importString(completion: ImportCompletion?) {
        let string = UIPasteboard.general.string
        if string == nil {
            completion?(getResult(withState: .cancelled))
        } else {
            completion?(getResult(withString: string!))
        }
    }
}
