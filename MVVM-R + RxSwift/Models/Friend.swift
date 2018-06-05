//
//  Friend.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 01/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation


struct FriendResponse: Codable {
    let response: Response?
    let error: ResponseError?
}

struct Response: Codable {
    let count: Int?
    let items: [Friend]?
}

struct Friend: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let photo100: String?
    let photoMaxOrig: String?
    let online: Int?
    let onlineMobile: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo100 = "photo_100"
        case photoMaxOrig = "photo_max_orig"
        case online
        case onlineMobile = "online_mobile"
    }
}
