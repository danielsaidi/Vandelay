//
//  ImportResult+AlertMessage.swift
//  VandelayDemo
//
//  Created by Daniel Saidi on 2019-10-08.
//

import Vandelay

extension ImportResult {
    
    var alertMessage: String {
        switch state {
        case .cancelled: return "The import was cancelled."
        case .completed: return "The import was successfully completed."
        case .failed: return "The import did fail: \(error?.localizedDescription ?? "No error information")."
        }
    }
}
