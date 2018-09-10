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

public class FileExporter: DataExporter, StringExporter {
    
     
    // MARK: Initialization
    
    public convenience init(fileName: String) {
        let generator = StaticFileNameGenerator(fileName: fileName)
        self.init(fileNameGenerator: generator)
    }
    
    public init(fileNameGenerator: FileNameGenerator) {
        self.fileNameGenerator = fileNameGenerator
    }
    
    
    // MARK: - Dependencies
    
    private let fileNameGenerator: FileNameGenerator
    
    
    // MARK: Properties
    
    public let exportMethod = ExportMethod.file
    
    
    // MARK: - Errors
    
    enum FileExporterError: Error {
        case invalidFilePath
        case stringCouldNotBeEncoded
    }
    
    
    // MARK: - DataExporter
    
    public func export(data: Data, completion: @escaping ExportCompletion) {
        guard let url = getFileUrl() else {
            let error = FileExporterError.invalidFilePath
            let result = ExportResult(method: exportMethod, error: error)
            return completion(result)
        }
        write(data: data, to: url, completion: completion)
    }
    
    
    // MARK: - StringExporter
    
    public func export(string: String, completion: @escaping ExportCompletion) {
        guard let data = string.data(using: .utf8) else {
            let error = FileExporterError.stringCouldNotBeEncoded
            let result = ExportResult(method: exportMethod, error: error)
            return completion(result)
        }
        export(data: data, completion: completion)
    }
}


// MARK: Private functions

private extension FileExporter {
    
    func getFileUrl() -> URL? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard paths.count > 0 else { return nil }
        let fileName = fileNameGenerator.getFileName()
        let filePath = "file://\(paths[0])/\(fileName)"
        return URL(string: filePath)
    }
    
    func write(data: Data, to url: URL, completion: @escaping ExportCompletion) {
        do {
            try data.write(to: url, options: .atomicWrite)
            var result = ExportResult(method: exportMethod, state: .completed)
            result.filePath = url.absoluteString
            completion(result)
        } catch {
            let result = ExportResult(method: exportMethod, error: error)
            completion(result)
        }
    }
}
