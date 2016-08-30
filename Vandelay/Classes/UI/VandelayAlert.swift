//
//  VandelayAlert.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-08-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//
//

import UIKit

public class VandelayAlert: UIAlertController {

    public func addCancelActionWithTitle(title: String) {
        let action = UIAlertAction(title: title, style: .Cancel) { action in }
        addAction(action)
    }
}
