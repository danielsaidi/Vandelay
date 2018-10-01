//
//  ExportMethod.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2018-09-11.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

public enum ExportMethod: Equatable {
    
    case
    custom(name: String),
    email,
    file,
    message,
    pasteboard
}
