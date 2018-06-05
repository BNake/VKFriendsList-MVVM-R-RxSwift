//
//  HTTPTask.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 02/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String:String]

enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
}


