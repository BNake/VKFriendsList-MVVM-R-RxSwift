//
//  ProfileResponde.swift
//  VK friend list
//
//  Created by Захар Бабкин on 23/04/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation


struct ProfileResponde: Codable {
    let response: [Profile]?
    let error: ResponseError?
}

struct Profile: Codable {
    let id: Int?
    let firstName, lastName, bdate: String?
    let city: City?
    let photo100: String?
    let photoMaxOrig: String?
    let isFriend, online: Int?
    let onlineApp: String?
    let onlineMobile: Int?
    let mobilePhone, homePhone, status: String?
    let followersCount, commonCount: Int?
    let counters: [String: Int]?
    let about: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case bdate, city
        case photo100 = "photo_100"
        case photoMaxOrig = "photo_max_orig"
        case isFriend = "is_friend"
        case online
        case onlineApp = "online_app"
        case onlineMobile = "online_mobile"
        case mobilePhone = "mobile_phone"
        case homePhone = "home_phone"
        case status
        case followersCount = "followers_count"
        case commonCount = "common_count"
        case counters
        case about
    }
}

struct City: Codable {
    let id: Int?
    let title: String?
}
