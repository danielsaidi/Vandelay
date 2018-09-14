//
//  AppDelegate.swift
//  VandelayExample
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import SwiftyDropbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupDropbox()
        return true
    }
}

private extension AppDelegate {
    
    func setupDropbox() {
        //DropboxClientsManager.setupWithAppKey("<APP_KEY>")
    }
}
