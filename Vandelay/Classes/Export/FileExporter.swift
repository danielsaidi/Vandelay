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
    
    private var fileNameGenerator: FileNameGenerator
    
    
    
    // MARK: Public functions
    
    public func exportData(_ data: Data, completion: ((_ result: ExportResult) -> ())?) {
        do {
            guard let url = getFileUrl() else {
                completion?(self.getResult(withErrorMessage: "Could not generate valid document url"))
                return
            }
            try data.write(to: url, options: .atomicWrite)
            let result = getResult(withFilePath: url.absoluteString )
            completion?(result)
        } catch {
            let message = error.localizedDescription
            completion?(self.getResult(withErrorMessage: message))
        }
    }
    
    public func exportString(_ string: String, completion: ((_ result: ExportResult) -> ())?) {
        do {
            guard let url = getFileUrl() else {
                completion?(self.getResult(withErrorMessage: "Could not generate valid document url"))
                return
            }
            try string.write(to: url, atomically: true, encoding: .utf8)
            let result = getResult(withFilePath: url.absoluteString )
            completion?(result)
        } catch {
            let message = error.localizedDescription
            completion?(self.getResult(withErrorMessage: message))
        }
    }
    
    
    
    // MARK: Private functions
    
    private func getFileUrl() -> URL? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard paths.count > 0 else { return nil }
        let fileName = fileNameGenerator.getFileName()
        let path = "file:///\(paths.first!)/\(fileName)"
        return URL(string: path)
    }
}
