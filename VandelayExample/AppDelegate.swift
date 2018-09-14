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
        let accounts = Accounts()
        setupDropbox(with: accounts.dropboxAppKey)
        return true
    }
}

private extension AppDelegate {
    
    func setupDropbox(with appKey: String) {
        guard appKey.count > 0 else { return }
        DropboxClientsManager.setupWithAppKey(appKey)
    }
}
