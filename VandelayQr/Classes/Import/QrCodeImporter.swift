//
//  DropboxImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-03.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This importer can be used to import strings & data by
 scanning a QR code.
 
 Since url importing is asynchronous, you will receive
 two callbacks - one to tell you that the import begun,
 and one to tell you if it succeeded or failed.
 
 */

import Foundation
import QRCodeReader
import Vandelay

public class QrCodeImporter: NSObject, DataImporter, StringImporter {
    
    public var importMethod: String { return "QR" }
    
    public func importData(completion: ((_ result: ImportResult) -> ())?) {
    }
    
    public func importString(completion: ((_ result: ImportResult) -> ())?) {
    }
    
}
