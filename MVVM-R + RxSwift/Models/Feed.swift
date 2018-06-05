//
//  Wall.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 03/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation


struct FeedResponse: Codable {
    let response: FeedResp?
    let error: ResponseError?
}

struct FeedResp: Codable {
    let count: Int?
    let items: [Feed]?
    let profiles: [ProfileFeed]?
    let groups: [GroupFeed]?
}

struct Feed: Codable {
    let id, fromID, ownerID, date: Int?
    let text: String?
    let attachments: [ItemAttachment]?
    let likes: Likes?
    let reposts: Reposts?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fromID = "from_id"
        case ownerID = "owner_id"
        case date
        case text, attachments
        case likes, reposts
    }
}

struct ItemAttachment: Codable {
    let type: String?
    let photo: Photo?
}
struct Photo: Codable {
    let id, albumID, ownerID: Int?
    let photo75, photo130, photo604, photo807: String?
    let photo1280: String?
    let width, height: Int?
    let text: String?
    let date, postID: Int?
    let accessKey, photo2560: String?
    let userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case photo75 = "photo_75"
        case photo130 = "photo_130"
        case photo604 = "photo_604"
        case photo807 = "photo_807"
        case photo1280 = "photo_1280"
        case width, height, text, date
        case postID = "post_id"
        case accessKey = "access_key"
        case photo2560 = "photo_2560"
        case userID = "user_id"
    }
}


struct Likes: Codable {
    let count, userLikes, canLike, canPublish: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

struct Reposts: Codable {
    let count, userReposted: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

struct ProfileFeed: Codable {
    let id: Int?
    let firstName, lastName: String?
    let sex: Int?
    let screenName, photo50, photo100: String?
    let online: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case online
    }
}

struct GroupFeed: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type, photo50, photo100, photo200: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}
