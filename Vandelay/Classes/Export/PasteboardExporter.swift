//
//  PasteboardExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-22.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can export strings and serialized data
 to the pasteboard.
 
 */

import UIKit

public class PasteboardExporter: NSObject, StringExporter {
    
    public private(set) var exportMethod = "Pasteboard"

    public func exportString(string: String, completion: ((result: ExportResult) -> ())?) {
        UIPasteboard.generalPasteboard().string = string
        completion?(result: getResultWithState(.Completed))
    }
}
