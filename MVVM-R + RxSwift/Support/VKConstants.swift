//
//  VKConstants.swift
//  VK friend list
//
//  Created by Захар Бабкин on 21/04/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation


enum VKConstants {
    static let applicationClientID = "6453468"
    static let version = "5.8"
    static let count = 50
    static var url: String {
        return "https://oauth.vk.com/authorize?client_id=\(VKConstants.applicationClientID)&redirect_uri=vk\(VKConstants.applicationClientID)://authorize&scope=friends,photos&display=mobile&response_type=token&v=\(VKConstants.version)"
    }
}
