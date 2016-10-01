//
//  UrlImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-08-31.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can import strings and data from custom
 urls, e.g. a file on the Internet, a REST api etc.
 
 Since url importing is asynchronous, you will receive
 two callbacks - one to tell you that the import begun,
 and one to tell you if it succeeded or failed.
 
 Make sure to adjust your Info.plist file to allow the
 app to request external urls, otherwise this importer
 will not work.
 
 */

import Foundation

public class UrlImporter: NSObject, DataImporter, StringImporter {
    
    
    // MARK: - Initialization
    
    public init(url: URL) {
        self.url = url
        super.init()
    }
    
    
    
    // MARK: - Properties
    
    public private(set) var importMethod = "URL"
    
    private var url: URL
    
    
    
    // MARK: - Public functions
    
    public func importData(completion: ((_ result: ImportResult) -> ())?) {
        completion?(ImportResult(state: .inProgress))
        
        do {
            let data = try Data(contentsOf: url)
            completion?(self.getResult(withData: data))
        } catch {
            completion?(self.getResult(withError: error))
        }
    }
    
    public func importString(completion: ((_ result: ImportResult) -> ())?) {
        completion?(ImportResult(state: .inProgress))
        
        do {
            let contents = try String(contentsOf: url, encoding: .utf8)
            completion?(self.getResult(withString: contents))
        } catch {
            completion?(self.getResult(withError: error))
        }
    }
}
