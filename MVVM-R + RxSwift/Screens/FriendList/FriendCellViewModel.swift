//
//  FriendCellViewModel.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 01/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import RxSwift
import RxCocoa


class ProfileHeaderCellViewModel {
    
    private let friend: Friend
    
    var photo: Driver<UIImage>
    var name: String { return friend.firstName ?? "" }
    var lastName: String { return friend.lastName ?? "" }
    var isOnline: Bool { return (friend.online ?? 0) == 1 ? true : false }
    
    init(friend: Friend) {
        self.friend = friend
        self.photo = UIImage.getImage(link: friend.photo100).asDriver(onErrorJustReturn: #imageLiteral(resourceName: "Guf"))
    }
}
