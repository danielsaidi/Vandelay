//
//  RandomFileNameGenerator.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2015-11-04.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This class can be used to generate a random file name.
 
 */

import Foundation

public class RandomFileNameGenerator: NSObject, FileNameGenerator {
    
    
    // MARK: Initialization
    
    public override init() {
        super.init()
    }
    
    public init(fileExtension: String) {
        self.fileExtension = fileExtension
        super.init()
    }
    
    
    
    // MARK: Properties
    
    private var fileExtension: String?
    
    
    
    // MARK: Public functions
    
    public func getFileName() -> String {
        let fileName = NSUUID().UUIDString
        return fileExtension == nil ? fileName : "\(fileName).\(fileExtension)"
    }
}
