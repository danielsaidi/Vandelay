//
//  UrlImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-08-31.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can import strings and data from a custom url,
 e.g. a file on the Internet, a REST api etc.
 
 Make sure to adjust the Info.plist file to allow the app to
 request external urls, otherwise the importer will not work.
 
 */

import Foundation

public class UrlImporter: DataImporter, StringImporter {
    
    
    // MARK: - Initialization
    
    public init(url: URL) {
        self.url = url
    }
    
    
    // MARK: - Properties
    
    public let importMethod = ImportMethod.url
    public let url: URL
    
    
    // MARK: - Public Functions
    
    public func importData(completion: @escaping ImportCompletion) {
        do {
            let data = try Data(contentsOf: url)
            let result = ImportResult(method: importMethod, data: data)
            completion(result)
        } catch {
            let result = ImportResult(method: importMethod, error: error)
            completion(result)
        }
    }
    
    public func importString(completion: @escaping ImportCompletion) {
        do {
            let string = try String(contentsOf: url, encoding: .utf8)
            let result = ImportResult(method: importMethod, string: string)
            completion(result)
        } catch {
            let result = ImportResult(method: importMethod, error: error)
            completion(result)
        }
    }
}
