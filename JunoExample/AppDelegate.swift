//
//  AppDelegate.swift
//  JunoExample
//
//  Created by Emre Onder on 13.12.2020.
//

import UIKit
import Juno
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let bounds = UIScreen.main.bounds
        window = UIWindow(frame: bounds)
        let mainController = ViewController()
        window?.rootViewController = UINavigationController(rootViewController: mainController)
        window?.makeKeyAndVisible()

        #if DEBUG
        Juno()
        #endif
        return true
    }
    
}

