//
//  Error.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 01/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation


struct ResponseError: Codable {
    let errorCode: Int?
    let errorMsg: String?
    
    enum CodingKeys: String, CodingKey{
        case errorCode = "error_code"
        case errorMsg = "error_msg"
    }
}
