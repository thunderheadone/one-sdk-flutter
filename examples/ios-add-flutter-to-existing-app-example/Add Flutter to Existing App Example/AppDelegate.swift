//
//  AppDelegate.swift
//  Add Flutter to Existing App Example
//
//  Created by Alex Nguyen on 6/2/21.
//

import UIKit
import Flutter
// Used to connect plugins (only if you have plugins with iOS platform code).
import FlutterPluginRegistrant
import Thunderhead

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run();
        // Used to connect plugins (only if you have plugins with iOS platform code).
        GeneratedPluginRegistrant.register(with: self.flutterEngine);
        
        // The Flutter module is integrated with the ONE Flutter Plugin for Flutter configuration.
        // Optionally, we can also configure the ONE SDK for native configuration.
        One.startSessionWithSK(
            "ONE-XXXXXXXXXX-1022",
            uri:"myAppsNameURI",
            apiKey:"f713d44a-8af0-4e79-ba7e-xxxxxxxxxxxxxxxx",
            sharedSecret:"bb8bacb2-ffc2-4c52-aaf4-xxxxxxxxxxxxxxxx",
            userId:"api@yourCompanyName", // when integrating with Interaction Studio use a numeric user id - see https://eu2.thunderhead.com/one/help/interaction-studio/how-do-i/mobile/one_integrate_mobile_find_integration_info/#username-user-id
            adminMode:false,
            hostName:"xx.thunderhead.com"
        )

        // For Interaction Studio, uncomment below
        // One.setTheme(.InteractionStudio)
                
        // To see an output of the requests/responses made by the SDK, uncomment below
        // One.setLogLevel(.All)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

