//
//  ExportResult+AlertMessage.swift
//  VandelayDemo
//
//  Created by Daniel Saidi on 2019-10-08.
//

import Vandelay

extension ExportResult {
    
    var alertMessage: String {
        switch state {
        case .cancelled: return "The export was cancelled."
        case .completed: return "The export was successfully completed."
        case .failed: return "The export did fail: \(error?.localizedDescription ?? "No error information")."
        case .unknown: return "The export is in an unknown state."
        }
    }
}
