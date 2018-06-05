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
    var fullName: String { return "aDSAsdASdasdasdasdASD"}
    var date: String { return "\(feed.date  ?? 123)"}
    var title: String { return feed.text ?? ""}
    var image = BehaviorSubject<[UIImage]>(value: [#imageLiteral(resourceName: "Guf")])
    var likesCount: String { return "\(feed.likes?.count ?? 0)"}
    var repostCount: String { return "\(feed.reposts?.count ?? 0)"}
    
    init(feed: Feed) {
        self.feed = feed
        self.photo = UIImage.getImage(link: feed.text).asDriver(onErrorJustReturn: #imageLiteral(resourceName: "Guf"))
        
//        var imageLinkArray = [String]()
//
//        feed.attachments?.filter({$0.type == "photo"}).forEach { attachmentPhoto in
//            let photo = attachmentPhoto.photo?.photo604
//            imageLinkArray.append(photo!)
//        }
//
//        UIImage.getImageArray(links: imageLinkArray) { images in
//            self.image.onNext(images)
//        }
    }
}
