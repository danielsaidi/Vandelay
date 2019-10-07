//
//  StaticFileNameGenerator.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-02.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

public class StaticFileNameGenerator: FileNameGenerator {
    
    public init(fileName: String) {
        self.fileName = fileName
    }
    
    public init(fileName: String, fileExtension: String) {
        self.fileName = "\(fileName).\(fileExtension)"
    }
    
    private let fileName: String
    
    public func getFileName() -> String {
        fileName
    }
}
