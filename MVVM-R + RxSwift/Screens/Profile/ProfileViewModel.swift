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
    
    var feed = BehaviorSubject(value: [FeedCellViewModel]())
    
    init(networkService: NetworkManager, id: Int) {
        self.networkService = networkService
        self.id = id
        
        networkService.getFeed(id: id).subscribe { feedResponse in
            guard let feedResponse = feedResponse.element else { return }
            var feedArray = [FeedCellViewModel]()
            feedResponse.response?.items?.forEach{ feed in
                let owner = feedResponse.response?.profiles?.filter{$0.id == feed.fromID}.first
                let name = (owner?.firstName ?? "Хуй") + " " + (owner?.lastName ?? "Болотный")
                feedArray.append(FeedCellViewModel(feed: feed, ownerName: name , ownerPhoto: owner?.photo100 ?? ""))
            }
            
            self.feed.onNext(feedArray)
            
        }.disposed(by: disposeBag)
        
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
