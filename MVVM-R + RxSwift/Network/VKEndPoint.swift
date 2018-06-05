//
//  MovieEndPoint.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public enum VKApi{
    case getFriends(id: Int?)
    case getUser(id: Int?)
    case getAllPhoto(id: Int?)
}

extension VKApi: EndPointType{
    var baseURL: URL {
        guard let url = URL(string: "https://api.vk.com/method/") else {fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getFriends: return "friends.get"
        case .getUser: return "users.get"
        case .getAllPhoto: return "photos.getAll"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var task: HTTPTask {
        let tokenApi = KeychainAPI()
        let token = tokenApi.loadToken()!
        
        switch self {
        case .getFriends(let id):
            var urlParameters: Parameters = ["access_token": token,
                                             "order": "hints",
                                             "fields": "online,photo_100,photo_max_orig",
                                             "v": "\(VKConstants.version)"]
            if let id = id {
                urlParameters.updateValue("\(id)", forKey: "user_id")
            }
            
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: urlParameters)
            
        case .getUser(let id):
            var urlParameters: Parameters = ["access_token": token,
                                             "fields": "photo_100,photo_max_orig,bdate,about,city,common_count,contacts,counters,followers_count,is_friend,online,status",
                                             "v": "\(VKConstants.version)"]
            if let id = id {
                urlParameters.updateValue("\(id)", forKey: "user_ids")
            }
            
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: urlParameters)
            
        case .getAllPhoto(let id):
            var urlParameters: Parameters = ["access_token": token,
                                             "v": "\(VKConstants.version)"]
            if let id = id {
                urlParameters.updateValue("\(id)", forKey: "owner_id")
            }
            
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: urlParameters)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
