//
//  FriendListViewModel.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 01/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import RxSwift
import RxCocoa


class FriendListViewModel: Routable {
    
    typealias RouterType = FriendListRouter
    var router: FriendListRouter?
    
    enum Routes {
        case profile(id: Int)
    }
    
    private let disposeBag = DisposeBag()
    
    private let networkService: NetworkManager
    private let id: Int
    
    var cellViewModel: Driver<[FriendCellViewModel]>?
    
    var viewModelSelected: Driver<FriendCellViewModel>! {
        didSet {
            if let viewModelSelected = self.viewModelSelected {
                viewModelSelected.map{$0.id}.drive(onNext: { [unowned self] id in
                    self.router?.route(to: .profile(id: id))
                }).disposed(by: disposeBag)
            }
        }
    }
    
    
    init(networkService: NetworkManager, id: Int) {
        self.networkService = networkService
        self.id = id
        getFriend()
    }
    
    func getFriend() {
        self.cellViewModel = networkService.getFriends(id: id)
            .map { friends in return friends.map { FriendCellViewModel(friend: $0) } }
            .asDriver(onErrorJustReturn: [])
    }
}
