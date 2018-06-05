//
//  AppDelegate.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 01/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let startViewController: UINavigationController = {
        let keychain = Keychain()
        let authViewController = AuthorizationViewController(keychain: keychain)
        let navigationController = UINavigationController.init(rootViewController: authViewController)
        
        let router = AuthorizationRouter()
        router.context = navigationController
        authViewController.router = router
        
        return navigationController
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = startViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if let sourceApplication = options[.sourceApplication] {
            if (String(describing: sourceApplication) == "com.apple.SafariViewService") {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "safariControllerNotificationName"), object: url)
                return true
            }
        }
        
        return false
    }
}

