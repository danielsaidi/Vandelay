//
//  DataExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

public protocol DataExporter: class, ExportContext {
    
    func exportData(data: NSData, completion: ((result: ExportResult) -> ()))
}