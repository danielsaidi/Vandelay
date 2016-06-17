//
//  ExportDataProvider.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-05-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

public protocol ExportDataProvider: class {
    
    func getExportData(completion: ((data: NSData?) -> ()))
    func getExportDataString(completion: ((string: String?) -> ()))
}
