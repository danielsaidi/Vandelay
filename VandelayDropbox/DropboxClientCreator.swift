//
//  DropboxClientCreator.swift
//  VandelayDropbox
//
//  Created by Daniel Saidi on 2018-09-14.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import SwiftyDropbox

protocol DropboxClientCreator {}

extension DropboxClientCreator {
    
    func createAuhorizedClient(from vc: UIViewController) {
        let app = UIApplication.shared
        DropboxClientsManager.authorizeFromController(app, controller: vc, openURL: { url in
            app.openURL(url)
        })
    }
}
