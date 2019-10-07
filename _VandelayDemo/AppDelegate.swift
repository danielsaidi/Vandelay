//
//  AppDelegate.swift
//  VandelayDropboxExample
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
//import SwiftyDropbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let accounts = Accounts()
        setupDropbox(with: accounts.dropboxAppKey)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        tryHandleDropboxAuth(with: url)
        return true
    }
}

private extension AppDelegate {
    
    func setupDropbox(with appKey: String) {
        guard appKey.count > 0 else { return }
//        DropboxClientsManager.setupWithAppKey(appKey)
    }
    
    func tryHandleDropboxAuth(with url: URL) {
//        if let result = DropboxClientsManager.handleRedirectURL(url) {
//            switch result {
//            case .success: print("Success! User is logged into Dropbox.")
//            case .cancel: print("Authorization flow was manually canceled by user!")
//            case .error(_, let description): print("Error: \(description)") }
//        }
    }
}
