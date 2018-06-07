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
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = createStartViewController()
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
    
    func createStartViewController() -> UIViewController {
        let keychain = Keychain()
        if keychain.load(.token) != nil, let idString = keychain.load(.id), let id = Int(idString) {
            let network = NetworkManager()
            let viewModel = FriendListViewModel(networkService: network, id: id)
            let friendLiewController = FriendListViewController(viewModel: viewModel)
            
            let navigationController = UINavigationController.init(rootViewController: friendLiewController)
            let router = FriendListRouter()
            router.context = navigationController
            viewModel.router = router
            
            return navigationController
        } else {
            let keychain = Keychain()
            let authViewController = AuthorizationViewController(keychain: keychain)
            let navigationController = UINavigationController.init(rootViewController: authViewController)
            
            let router = AuthorizationRouter()
            router.context = navigationController
            authViewController.router = router
            
            return navigationController
        }
    }
}

