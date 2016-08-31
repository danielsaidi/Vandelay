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
    
    
    // MARK: Initialization
    
    public init(url: NSURL) {
        self.url = url
        super.init()
    }
    
    
    
    // MARK: Properties
    
    public private(set) var importMethod = "URL"
    
    private var url: NSURL
    
    
    
    // MARK: Public functions
    
    public func importData(completion: ((result: ImportResult) -> ())?) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            if (error != nil) {
                completion?(result: self.getResultWithError(error!))
            } else if (data != nil) {
                completion?(result: self.getResultWithData(data!))
            } else {
                completion?(result: self.getResultWithErrorMessage("No data in url \(self.url)"))
            }
        }
        task.resume()
    }
}
