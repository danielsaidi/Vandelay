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


import UIKit

public class UrlImporter: NSObject, DataImporter, StringImporter {
    
    
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
        do {
            let data = try NSData(contentsOfURL: url)
            if (data != nil) {
                completion?(result: getResultWithData(data!))
            } else {
                completion?(result: self.getResultWithErrorMessage("No data in url \(url)"))
            }
        } catch {
            completion?(result: self.getResultWithError(error as NSError))
        }
    }
    
    public func importString(completion: ((result: ImportResult) -> ())?) {
        do {
            let string = try String(contentsOfURL: url)
            completion?(result: getResultWithString(string))
        } catch {
            completion?(result: self.getResultWithError(error as NSError))
        }
    }
}
