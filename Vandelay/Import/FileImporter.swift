//
//  FileImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can import strings and data from files in the
 app's document directory.
 
 Use the `fileName` initializer if the imported files should
 have the same name at all times. Use the `fileNameGenerator`
 initializer if you require dynamic file names.
 
 */

import UIKit

public class FileImporter: DataImporter, StringImporter {
    
    
    // MARK: Initialization
    
    public init(fileName: String) {
        self.fileName = fileName
    }
    
    
    // MARK: - Properties
    
    public let importMethod = ImportMethod.file
    
    private let fileName: String
    
    
    // MARK: - Errors
    
    enum ImportError: Error {
        case invalidFilePath
    }
    
    
    // MARK: - Public Functions
    
    public func importData(completion: @escaping ImportCompletion) {
        guard let url = getFileUrl() else {
            let result = ImportResult(method: importMethod, error: ImportError.invalidFilePath)
            return completion(result)
        }

        do {
            let data = try Data(contentsOf: url, options: .uncachedRead)
            let result = ImportResult(method: importMethod, data: data)
            completion(result)
        } catch {
            let result = ImportResult(method: importMethod, error: ImportError.invalidFilePath)
            completion(result)
        }
    }
    
    public func importString(completion: @escaping ImportCompletion) {
        guard let path = getFilePath() else {
            let result = ImportResult(method: importMethod, error: ImportError.invalidFilePath)
            return completion(result)
        }

        do {
            let string = try String(contentsOfFile: path, encoding: .utf8)
            let result = ImportResult(method: importMethod, string: string)
            completion(result)
        } catch {
            let result = ImportResult(method: importMethod, error: ImportError.invalidFilePath)
            completion(result)
        }
    }
}


// MARK: - Private Functions

private extension FileImporter {
    
    func getFilePath() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let path = paths.first else { return nil }
        return "\(path)/\(fileName)"
    }
    
    func getFileUrl() -> URL? {
        guard let path = getFilePath() else { return nil }
        return URL(string: "file://\(path)")
    }
}
