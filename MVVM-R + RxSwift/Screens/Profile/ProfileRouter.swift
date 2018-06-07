//
//  ProfileRouter.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 05/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit


class ProfileRouter: Router {
    typealias RoutableType = ProfileViewModel
    
    typealias Context = UINavigationController
    weak var context: Context?
    
    func route(to route: ProfileViewModel.Routes) {
        switch route {
        case .detail(let photo):
            let detailPhotoViewController = DetailPhotoViewController(photo: photo)
            context?.pushViewController(detailPhotoViewController, animated: true)
            
        case .friendList(let id):
            let network = NetworkManager()
            let viewModel = FriendListViewModel(networkService: network, id: id)
            let friendLiewController = FriendListViewController(viewModel: viewModel)
            
            context?.pushViewController(friendLiewController, animated: true)
            
            let router = FriendListRouter()
            router.context = context
            viewModel.router = router
            
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
