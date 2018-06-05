//
//  ProfileViewModel.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 03/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import RxSwift
import RxCocoa


class ProfileViewModel: Routable {
    
    typealias RouterType = ProfileRouter
    var router: ProfileRouter?
    
    enum Routes {
        case detail(photo: [UIImage])
        case friendList(id: Int)
    }
    
    
    private let disposeBag = DisposeBag()
    
    private let networkService: NetworkManager
    private let id: Int
    
    var photo = BehaviorSubject(value: #imageLiteral(resourceName: "Guf"))
    var fullName = BehaviorSubject(value: "")
    var onlineStatus = BehaviorSubject(value: "")
    var city = BehaviorSubject(value: "")
    
    let feed: Driver<[FeedCellViewModel]>
    
    init(networkService: NetworkManager, id: Int) {
        self.networkService = networkService
        self.id = id
        
        self.feed = networkService.getFeed(id: id)
            .map { feeds in return feeds.map { FeedCellViewModel(feed: $0) } }
            .asDriver(onErrorJustReturn: [])
        
        networkService.getProfile(id: id).map{$0.first!}.subscribe { profile in
            guard let profile = profile.element else { return }
            UIImage.getImage(link: profile.photoMaxOrig).bind(to: self.photo).disposed(by: self.disposeBag)
            self.fullName.onNext((profile.firstName ?? "") + " " + (profile.lastName ?? ""))
            self.onlineStatus.onNext((profile.online ?? 0) == 1 ? "online" : "offline" )
            self.city.onNext(profile.city?.title ?? "")
        }.disposed(by: disposeBag)
    }
    
    func detailPhoto(_ photo: UIImage) {
        self.router?.route(to: .detail(photo: [photo]))
    }
    
    func friendList(){
        self.router?.route(to: .friendList(id: id))
    }
}


struct readyProfile {
    var photo: UIImage
    var fullName: String
    var onlineStatis: String
    var city: String
}
