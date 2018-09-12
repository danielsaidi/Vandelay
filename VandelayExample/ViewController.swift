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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let obj = TestClass(name: "name", date: Date(), isEmpty: true)
        exporter = FileExporter(fileName: "foo.json")
        exporter.exportString(for: obj, encoder: JSONEncoder()) { (result) in
            print(result)
            
            self.importer = FileImporter(fileName: "foo.json")
            self.importer.importString { (result) in
                print(result)
            }
        }
    }

    var exporter: StringExporter!
    var importer: StringImporter!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
