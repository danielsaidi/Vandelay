//
//  StaticFileNameGenerator.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-02.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

public class StaticFileNameGenerator: NSObject, FileNameGenerator {
    
    
    // MARK: - Initialization
    
    public init(fileName: String) {
        self.fileName = fileName
        super.init()
    }
    
    public init(fileName: String, fileExtension: String) {
        self.fileName = "\(fileName).\(fileExtension)"
        super.init()
    }
    
    
    
    // MARK: - Properties
    
    private var fileName: String
    
    
    
    // MARK: - Public functions
    
    public func getFileName() -> String {
        return fileName
    }
}
