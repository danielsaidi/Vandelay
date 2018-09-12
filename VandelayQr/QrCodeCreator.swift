//
//  QrCodeCreator.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-10-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public protocol QrCodeCreator {
    
    func createQrCode(fromUrl url: URL) -> UIImage?
    func createQrCode(fromUrlString string: String) -> UIImage?
}
