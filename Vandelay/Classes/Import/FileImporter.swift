//
//  FileImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can import strings and data from a file
 in the app's document directory.
 
 Use the fileName initializer if your file should have
 the same name at all times. Use the fileNameGenerator
 initializer if you require dynamic file names.
 
 */


import UIKit

public class FileImporter{/* TODO: NSObject, DataImporter, StringImporter {
    
    
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
    
    public func importData(completion: ((_ result: ImportResult) -> ())?) {
        do {
            let filePath = getFilePath()
            let data = try NSData(contentsOfFile: filePath, options: .uncachedRead)
            completion?(getResultWithData(data: data))
        } catch {
            completion?(self.getResultWithError(error: error as NSError))
        }
    }
    
    public func importString(completion: ((_ result: ImportResult) -> ())?) {
        do {
            let filePath = getFilePath()
            let string = try String(contentsOfFile: filePath)
            completion?(getResultWithString(string: string))
        } catch {
            completion?(self.getResultWithError(error: error as NSError))
        }
    }
    
    
    // MARK: Private functions
    
    private func getFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let fileName = fileNameGenerator.getFileName()
        return "\(paths.first!)/\(fileName)"
    }*/
}
