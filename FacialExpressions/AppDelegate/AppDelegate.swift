//
//  AppDelegate.swift
//  FacialExpressions
//
//  Created by Arash Z.Jahangiri on 12/21/19.
//  Copyright © 2019 Arash. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = ViewController()
        let navController = UINavigationController(rootViewController: rootViewController)
        
        window?.rootViewController = navController
        
        window?.makeKeyAndVisible()
        return true
    }
}

