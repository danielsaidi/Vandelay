//
//  ImportMethod.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

public enum ImportMethod: Equatable {
    
    case
    custom(name: String),
    dropbox,
    file,
    pasteboard,
    qrCode,
    url
}
