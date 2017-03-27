//
//  AppDelegate.swift
//  MacysChallenge
//
//  Created by parry on 3/22/17.
//  Copyright © 2017 parry. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        UIApplication.shared.isStatusBarHidden = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SearchViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
}

