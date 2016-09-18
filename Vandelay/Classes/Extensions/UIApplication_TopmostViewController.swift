//
//  UIApplication_TopmostViewController.swift
//  Pods
//
//  Created by Daniel Saidi on 2016-09-18.
//
//

import UIKit

public extension UIApplication {
    
    public var topmostViewController: UIViewController? {
        if var vc = keyWindow?.rootViewController {
            while let presentedViewController = vc.presentedViewController {
                vc = presentedViewController
            }
            return vc
        }
        return nil
    }

}
