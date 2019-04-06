//
//  AppDelegate.swift
//  NSKeyedArchiverIntroduction
//
//  Created by Florian LUDOT on 3/26/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let apiProvider = APIProvider()
        let weatherViewController = WeatherViewController(apiProvider: apiProvider)
        window?.rootViewController = UINavigationController(rootViewController: weatherViewController)
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

