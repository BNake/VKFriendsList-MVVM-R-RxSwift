//
//  FriendListRouter.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 04/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit


class FriendListRouter: Router {
    typealias RoutableType = FriendListViewModel
    
    typealias Context = UINavigationController
    weak var context: Context?

    func route(to route: FriendListViewModel.Routes) {
        switch route {
        case .profile(let id):
            let network = NetworkManager()
            let profileViewModel = ProfileViewModel(networkService: network, id: id)
            let profileViewController = ProfileViewController(viewModel: profileViewModel)
            context?.pushViewController(profileViewController, animated: true)
            
            let router = ProfileRouter()
            router.context = context
            profileViewModel.router = router
        }
    }
}

