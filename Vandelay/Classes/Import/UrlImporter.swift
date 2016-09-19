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
 
 */


import Foundation

public class UrlImporter: NSObject, DataImporter {
    
    
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
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion?(self.getResult(withError: error!))
            } else if (data != nil) {
                completion?(self.getResult(withData: data!))
            } else {
                completion?(self.getResult(withErrorMessage: "No data in \(self.url)"))
            }
        }
        task.resume()
    }
}
