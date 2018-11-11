//
//  Accounts.swift
//  VandelayDropboxExample
//
//  Created by Daniel Saidi on 2018-09-14.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

class Accounts {

    // MARK: - Initialization
    
    public init() {
        do {
            let data = try Bundle.main.readFile("Accounts", ofType: "plist")
            dropboxAppKey = try data.string(forKey: "DropboxAppKey")
        } catch { fatalError(error.localizedDescription) }
    }
    
    
    // MARK: - Properties
    
    public let dropboxAppKey: String
    
    public var hasDropboxAppKey: Bool {
        return dropboxAppKey.count > 0
    }
}


// MARK: - Bundle Extensions

private extension Bundle {
    
    enum FileError: Error {
        case fileNotFound(String)
    }
    
    func readFile(_ fileName: String, ofType type: String) throws -> NSDictionary {
        guard
            let path = path(forResource: fileName, ofType: type),
            let data = NSDictionary(contentsOfFile: path)
            else { throw FileError.fileNotFound(fileName) }
        return data
    }
}


// MARK: - NSDictionary Extensions

private extension NSDictionary {
    
    enum CastError: Error {
        case invalidStringCastForKey(String)
    }
    
    func string(forKey key: String) throws -> String {
        guard
            let value = value(forKey: key) as? String
            else { throw CastError.invalidStringCastForKey(key) }
        return value
    }
}
