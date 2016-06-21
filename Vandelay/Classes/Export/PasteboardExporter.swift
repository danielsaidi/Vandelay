//
//  PasteboardExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-22.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can be used to export to the pasteboard.
 It only supports strings.
 
 */


import UIKit

public class PasteboardExporter: NSObject, StringExporter {
    
    public var exportMethod: String? { return "Pasteboard" }

    public func exportString(string: String, completion: ((result: ExportResult) -> ())) {
        UIPasteboard.generalPasteboard().string = string
        completion(result: getResultWithState(.Completed))
    }
}
