//
//  PasteboardImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can import strings and serialized data
 from the pasteboard.
 
 */

import UIKit

public class PasteboardImporter: NSObject, StringImporter {

    public private(set) var importMethod = "Pasteboard"
    
    public func importString(completion: ((result: ImportResult) -> ())?) {
        let string = UIPasteboard.generalPasteboard().string
        if (string == nil) {
            completion?(result: getResultWithState(.Cancelled))
        } else {
            completion?(result: getResultWithString(string!))
        }
    }
}
