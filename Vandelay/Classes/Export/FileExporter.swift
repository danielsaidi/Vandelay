//
//  FileExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-02.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can export strings and data to files in
 the app's document directory.
 
 Use the fileName initializer if your file should have
 the same name at all times. Use the fileNameGenerator
 initializer if you require dynamic file names.
 
 */

import Foundation

public class FileExporter: NSObject, DataExporter, StringExporter {
    
     
    // MARK: Initialization
    
    public convenience init(fileName: String) {
        let generator = StaticFileNameGenerator(fileName: fileName)
        self.init(fileNameGenerator: generator)
    }
    
    public init(fileNameGenerator: FileNameGenerator) {
        self.fileNameGenerator = fileNameGenerator
        super.init()
    }
    
    
    
    // MARK: Properties
    
    public private(set) var exportMethod = "File"
    
    public var errorMessageForFailedDataExport = "FileExporter could not export data to local file."
    public var errorMessageForFailedStringExport = "FileExporter could not export string to local file."
    
    private var fileNameGenerator: FileNameGenerator
    
    
    
    // MARK: Public functions
    
    public func export(data: Data, completion: ((_ result: ExportResult) -> ())?) {
        do {
            let filePath = getPath()!
            let url = URL(string: filePath)!
            try data.write(to: url, options: .atomicWrite)
            let result = getResult(withFilePath: filePath)
            completion?(result)
        } catch {
            print(error.localizedDescription)
            let errorMessage = errorMessageForFailedDataExport
            completion?(self.getResult(withErrorMessage: errorMessage))
        }
    }
    
    public func export(string: String, completion: ((_ result: ExportResult) -> ())?) {
        do {
            let filePath = getPath()!
            let url = URL(string: filePath)!
            try string.write(to: url, atomically: true, encoding: .utf8)
            let result = getResult(withFilePath: filePath)
            completion?(result)
        } catch {
            print(error.localizedDescription)
            let errorMessage = errorMessageForFailedStringExport
            completion?(self.getResult(withErrorMessage: errorMessage))
        }
    }
    
    
    
    // MARK: Private functions
    
    private func getPath() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard paths.count > 0 else { return nil }
        let fileName = fileNameGenerator.getFileName()
        return "file://\(paths.first!)/\(fileName)"
    }
}
