//
//  RandomFileNameGenerator.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-04.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

public class RandomFileNameGenerator: FileNameGenerator {
    
    public init(fileExtension: String) {
        self.fileExtension = fileExtension
    }
    
    private let fileExtension: String
    
    public func getFileName() -> String {
        let fileName = NSUUID().uuidString
        return "\(fileName).\(fileExtension)"
    }
}
