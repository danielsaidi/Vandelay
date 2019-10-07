//
//  PasteboardExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-22.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

#if !os(macOS)
import UIKit

/**
 This exporter can export strings to the system pasteboard.
 */
public class PasteboardExporter: StringExporter {
    
    public init() {}
    
    public let exportMethod = ExportMethod.pasteboard

    public func export(string: String, completion: @escaping ExportCompletion) {
        UIPasteboard.general.string = string
        let result = ExportResult(method: exportMethod, state: .completed)
        completion(result)
    }
}
#endif
