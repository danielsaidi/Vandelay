//
//  ViewController.swift
//  VandelayExample
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import Vandelay
import VandelayQr
import VandelayDropbox

struct TestClass: Codable {
    
    var name: String
    var date: Date
    var isEmpty: Bool
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://vinylsamlaren.se/api/stores/"
        let img = StandardQrCodeCreator(scale: 6).createQrCode(fromUrlString: url)
        let imgView = UIImageView(image: img)
        imgView.center = view.center
        view.addSubview(imgView)
        
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        importer = QrCodeImporter(fromViewController: self)
        importer.importString { (result) in
            print(result)
        }
    }

    var exporter: StringExporter!
    var importer: StringImporter!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
