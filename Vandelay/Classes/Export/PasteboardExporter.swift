//
//  PasteboardExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-22.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can export strings to the pasteboard.
 
 */

import UIKit

public class PasteboardExporter: NSObject, StringExporter {
    
    public private(set) var exportMethod = "Pasteboard"

    public func exportString(_ string: String, completion: ((_ result: ExportResult) -> ())?) {
        UIPasteboard.general.string = string
        completion?(getResult(withState: .completed))
    }
}
