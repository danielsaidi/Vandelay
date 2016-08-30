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
 
 Use the fileName initializer if your file should have
 the same name at all times. Use the fileNameGenerator
 initializer if you require dynamic file names.
 
 */

import Foundation

public class FileExporter: NSObject, DataExporter, StringExporter {
    
    
    // MARK: Initialization
    
    public convenience init(fileName: String) {
        self.init(fileNameGenerator: StaticFileNameGenerator(fileName: fileName))
    }
    
    public init(fileNameGenerator: FileNameGenerator) {
        self.fileNameGenerator = fileNameGenerator
        super.init()
    }
    
    
    
    // MARK: Properties
    
    public private(set) var exportMethod = "File"
    
    private var fileNameGenerator: FileNameGenerator
    
    
    
    // MARK: Public functions
    
    public func exportData(data: NSData, completion: ((result: ExportResult) -> ())?) {
        let filePath = getFilePath()
        do {
            try data.writeToFile(filePath, options: .AtomicWrite)
        } catch {
            completion?(result: self.getResultWithError(error as NSError))
        }
        completion?(result: getResultWithFilePath(filePath))
    }
    
    public func exportString(string: String, completion: ((result: ExportResult) -> ())?) {
        let filePath = getFilePath()
        do {
            try string.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
            completion?(result: self.getResultWithError(error as NSError))
        }
        completion?(result: getResultWithFilePath(filePath))
    }
    
    
    
    // MARK: Private functions
    
    private func getFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let fileName = fileNameGenerator.getFileName()
        return "\(paths.first!)/\(fileName)"
    }
}
