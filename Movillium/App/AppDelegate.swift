//
//  AppDelegate.swift
//  Movillium
//
//  Created by Ayberk Mogol on 10.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let initialVC = MainViewController()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: initialVC)
        self.window = window
        
        return true
    }

     


}

