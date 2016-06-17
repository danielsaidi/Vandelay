//
//  ClipboardExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-22.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This is a simple exporter that should only be used to
 export strings or a serialized data to the clipboard.
 
 */


import UIKit

public class ClipboardExporter: NSObject, StringExporter {
    
    public var context: String? { return "Clipboard" }

    public func exportString(string: String, completion: ((result: ExportResult) -> ())) {
        UIPasteboard.generalPasteboard().string = string
        completion(result: ExportResult(state: .Completed))
    }
}
