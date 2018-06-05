//
//  VKEndPont.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 02/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//


import RxSwift

import Foundation

public enum VKApi{
    case getFriends(id: Int)
    case getProfile(id: Int)
    case getFeed(id: Int)
}

extension VKApi: EndPointType{
    var baseURL: URL {
        guard let url = URL(string: "https://api.vk.com/method/") else {fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getFriends: return "friends.get"
        case .getProfile: return "users.get"
        case .getFeed: return "wall.get"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var task: HTTPTask {
        let keychain = Keychain()
        let token = keychain.load(.token)!
        
        switch self {
        case .getFriends(let id):
            let urlParameters: Parameters = ["access_token": token,
                                             "order": "hints",
                                             "fields": "online,photo_100,photo_max_orig",
                                             "v": "\(VKConstants.version)",
                                             "user_id": id]
            
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: urlParameters)
            
        case .getProfile(let id):
            let urlParameters: Parameters = ["access_token": token,
                                             "fields": "photo_100,photo_max_orig,bdate,about,city,common_count,contacts,counters,followers_count,is_friend,online,status",
                                             "v": "\(VKConstants.version)",
                                             "user_ids": id]
            
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: urlParameters)
            
        case .getFeed(let id):
            let urlParameters: Parameters = ["access_token": token,
                                             "v": "\(VKConstants.version)",
                                                "owner_id": id,
                                                "offset": 0]
            
            //TODO: offset
            
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: urlParameters)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
