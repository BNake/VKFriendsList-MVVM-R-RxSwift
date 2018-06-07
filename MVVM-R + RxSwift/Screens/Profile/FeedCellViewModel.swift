//
//  FeedCellViewModel.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 04/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import RxSwift
import RxCocoa


class FeedCellViewModel {
    
    private let feed: Feed
    private let disposeBag = DisposeBag()
    
    var photo: Driver<UIImage>
    var fullName: String
    var date: String { return (feed.date  ?? 123).getDateStringFromUnixTime(dateStyle: DateFormatter.Style.medium, timeStyle: .none)}
    var title: String { return feed.text ?? ""}
    var images = BehaviorSubject<[UIImage]>(value: [#imageLiteral(resourceName: "Guf")])
    var likesCount: String { return "\(feed.likes?.count ?? 0)"}
    var repostCount: String { return "\(feed.reposts?.count ?? 0)"}
    var id: Int { return feed.fromID ?? 00}
    
    init(feed: Feed, ownerName: String, ownerPhoto: String) {
        self.feed = feed
        self.fullName = ownerName
        self.photo = UIImage.getImage(link: ownerPhoto).asDriver(onErrorJustReturn: #imageLiteral(resourceName: "Guf"))
        
//        var imageLinkArray = [String]()
//        feed.attachments?.filter{$0.type! == "photo"}.forEach{imageLinkArray.append(($0.photo?.photo604)!)}
//        UIImage.getImageArray(links: imageLinkArray) { images in
//            print("Добавил \(images.count)")
//            self.images.onNext(images)
//        }
    }
}
