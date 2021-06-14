//
//  FlutterViewController.swift
//  Add Flutter to Existing App Example
//
//  Created by Alex Nguyen on 6/3/21.
//

import UIKit
import Flutter
import FlutterPluginRegistrant
class FlutterVC: FlutterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // !!! MUST call this method if subclassing `FlutterViewController` in order for the one_sdk_flutter plugin to work. !!!
        // Used to connect plugins (only if you have plugins with iOS platform code).
        GeneratedPluginRegistrant.register(with: self);
    }
    
    override var engine: FlutterEngine? {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        return flutterEngine
    }
}
