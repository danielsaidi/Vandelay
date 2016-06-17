//
//  FileExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-02.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can be used to save strings and data to
 the local file system.
 
 The file name generator that you must provide, can be
 any of the file name generators that are available in
 Vandelay, or any custom generator you like. Just make
 sure to use a non-random generator if you plan to use
 the file for syncing data across devices.
 
 */


import UIKit

public class FileExporter: NSObject, DataExporter, StringExporter {
    
    
    // MARK: Initialization
    
    public init(fileNameGenerator: FileNameGenerator) {
        self.fileNameGenerator = fileNameGenerator
        super.init()
    }
    
    
    
    // MARK: Properties
    
    public var context: String? { return "File" }
    
    private var fileNameGenerator: FileNameGenerator
    
    
    
    // MARK: Public functions
    
    public func exportData(data: NSData, completion: ((result: ExportResult) -> ())) {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let fileName = fileNameGenerator.getFileName()
        let filePath = "\(paths.first!)/\(fileName)"
        do {
            try data.writeToFile(filePath, options: .AtomicWrite)
        } catch {
            completion(result: self.getResultWithError(error as NSError))
        }
        completion(result: getResultWithFilePath(filePath))
    }
    
    public func exportString(string: String, completion: ((result: ExportResult) -> ())) {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let fileName = fileNameGenerator.getFileName()
        let filePath = "\(paths.first!)/\(fileName)"
        do {
            try string.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
            completion(result: self.getResultWithError(error as NSError))
        }
        completion(result: getResultWithFilePath(filePath))
    }
}
