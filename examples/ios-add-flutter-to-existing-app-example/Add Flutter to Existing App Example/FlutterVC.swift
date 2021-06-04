//
//  FlutterViewController.swift
//  Add Flutter to Existing App Example
//
//  Created by Alex Nguyen on 6/3/21.
//

import UIKit
import Flutter

class FlutterVC: FlutterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var engine: FlutterEngine? {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        return flutterEngine
    }
}
