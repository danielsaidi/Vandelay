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

public class FileExporter: NSObject{/* TODO , DataExporter, StringExporter {
    
     
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
    
    public func export(data: Data, completion: ((_ result: ExportResult) -> ())?) {
        let filePath = getFilePath()
        do {
            try data.write(to: withFilePath, options: .atomicWrite)
        } catch {
            completion?(self.getResult(withError: error))
        }
        completion?(getResult(withFilePath: filePath))
    }
    
    public func export(string: String, completion: ((_ result: ExportResult) -> ())?) {
        guard
            let filePath = getFilePath(),
            let url = URL(string: filePath) else {
                let result = getResult(withErrorMessage: "foo")
                completion(getResult(withErrorMessage: "Could not generate a valid file url"))
        }
        
        string.write(to: url, atomically: true, encoding: .utf8)
        completion?(getResult(withFilePath: filePath))
    }
    
    
    
    // MARK: Private functions
    
    private func getFilePath() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard paths.count > 0 else { return nil }
        let fileName = fileNameGenerator.getFileName()
        return "\(paths.first!)/\(fileName)"
    }
 */
}
