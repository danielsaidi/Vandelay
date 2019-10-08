//
//  SceneDelegate.swift
//  VandelayDemo
//
//  Created by Daniel Saidi on 2019-10-07.
//

import UIKit
import Vandelay

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate, IncomingFileHandler {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        connectionOptions.urlContexts.forEach { performImportOnStart(from: $0.url) }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        URLContexts.forEach { performImport(from: $0.url) }
    }
}
