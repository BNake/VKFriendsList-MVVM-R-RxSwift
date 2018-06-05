//
//  AuthorizationRouter.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 05/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit


class AuthorizationRouter: Router {
    typealias RoutableType = AuthorizationViewController
    
    typealias Context = UINavigationController
    weak var context: Context?
    
    func route(to route: AuthorizationViewController.Routes) {
        switch route {
        case .friendList(let id):
            let network = NetworkManager()
            let viewModel = FriendListViewModel(networkService: network, id: id)
            let friendLiewController = FriendListViewController(viewModel: viewModel)
            
            let navigationController = UINavigationController(rootViewController: friendLiewController)
            
            UIApplication.shared.keyWindow?.rootViewController = navigationController
            
            let router = FriendListRouter()
            router.context = navigationController
            viewModel.router = router
        }
    }
}
