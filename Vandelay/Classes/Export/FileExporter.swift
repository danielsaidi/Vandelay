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
    
    public var errorMessageForInvalidFilePath = "FileExporter could not retrieve a valid file path."
    
    private var fileNameGenerator: FileNameGenerator
    
    
    
    // MARK: Public functions
    
    public func export(data: Data, completion: ExportCompletion?) {
        guard let path = getFilePath(), let url = getFileUrl() else {
            completion?(getResult(withErrorMessage: errorMessageForInvalidFilePath))
            return
        }
        
        do {
            try data.write(to: url, options: .atomicWrite)
            let result = getResult(withFilePath: path)
            completion?(result)
        } catch {
            completion?(self.getResult(withErrorMessage: error.localizedDescription))
        }
    }
    
    public func export(string: String, completion: ExportCompletion?) {
        guard let path = getFilePath(), let url = getFileUrl() else {
            completion?(getResult(withErrorMessage: errorMessageForInvalidFilePath))
            return
        }
        
        do {
            try string.write(to: url, atomically: true, encoding: .utf8)
            let result = getResult(withFilePath: path)
            completion?(result)
        } catch {
            completion?(self.getResult(withErrorMessage: error.localizedDescription))
        }
    }
    
    
    
    // MARK: Private functions
    
    private func getFilePath() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard paths.count > 0 else { return nil }
        let fileName = fileNameGenerator.getFileName()
        return "file://\(paths.first!)/\(fileName)"
    }
    
    private func getFileUrl() -> URL? {
        guard let path = getFilePath() else { return nil }
        return URL(string: path)
    }
}
