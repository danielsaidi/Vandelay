//
//  FileImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This importer can be used to load strings and data in
 files on the local file system.
 
 Use the fileName initializer if your file should have
 the same name at all times. Use the fileNameGenerator
 initializer if you require dynamic file names.
 
 */


import UIKit

public class FileImporter: NSObject, DataImporter, StringImporter {
    
    
    // MARK: Initialization
    
    public convenience init(fileName: String) {
        self.init(fileNameGenerator: StaticFileNameGenerator(fileName: fileName))
    }
    
    public init(fileNameGenerator: FileNameGenerator) {
        self.fileNameGenerator = fileNameGenerator
        super.init()
    }
    
    
    
    // MARK: Properties
    
    public private(set) var importMethod = "File"
    
    private var fileNameGenerator: FileNameGenerator
    
    
    
    // MARK: Public functions
    
    public func importData(completion: ((result: ImportResult) -> ())?) {
        do {
            let filePath = getFilePath()
            let data = try NSData(contentsOfFile: filePath, options: .DataReadingUncached)
            completion?(result: getResultWithData(data))
        } catch {
            completion?(result: self.getResultWithError(error as NSError))
        }
    }
    
    public func importString(completion: ((result: ImportResult) -> ())?) {
        do {
            let filePath = getFilePath()
            let string = try String(contentsOfFile: filePath)
            completion?(result: getResultWithString(string))
        } catch {
            completion?(result: self.getResultWithError(error as NSError))
        }
    }
    
    
    // MARK: Private functions
    
    private func getFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let fileName = fileNameGenerator.getFileName()
        return "\(paths.first!)/\(fileName)"
    }
}
