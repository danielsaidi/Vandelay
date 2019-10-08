//
//  FileExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-02.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This exporter can export strings and data to files that end
 are stored in the app's document directory.
 
 Use the `fileName` initializer if the exported files should
 have the same name at all times. Use the `fileNameGenerator`
 initializer if you require dynamic file names.
 */
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
    
    enum ExportError: Error {
        case invalidFilePath
        case stringCouldNotBeEncoded
    }
    
    
    // MARK: - DataExporter
    
    public func export(data: Data, completion: @escaping ExportCompletion) {
        guard let url = getFileUrl() else {
            let error = ExportError.invalidFilePath
            let result = ExportResult(method: exportMethod, error: error)
            return completion(result)
        }
        write(data: data, to: url, completion: completion)
    }
    
    
    // MARK: - StringExporter
    
    public func export(string: String, completion: @escaping ExportCompletion) {
        guard let data = string.data(using: .utf8) else {
            let error = ExportError.stringCouldNotBeEncoded
            let result = ExportResult(method: exportMethod, error: error)
            return completion(result)
        }
        export(data: data, completion: completion)
    }
    
    
    // MARK: - Functions
    
    public func getFileUrl() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard paths.count > 0 else { return nil }
        let fileName = fileNameGenerator.getFileName()
        let filePath = "file://\(paths[0])/\(fileName)"
        return URL(string: filePath)
    }
}


// MARK: Private functions

private extension FileExporter {
    
    func write(data: Data, to url: URL, completion: @escaping ExportCompletion) {
        do {
            try data.write(to: url, options: .atomicWrite)
            let result = ExportResult(method: exportMethod, filePath: url.absoluteString)
            completion(result)
        } catch {
            let result = ExportResult(method: exportMethod, error: error)
            completion(result)
        }
    }
}
