//
//  URL+Token+Id.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 05/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation


extension URL {
    var accessToken: String? {
        let string = self.absoluteString
        
        do {
            let regular = try NSRegularExpression(pattern: "(?<=access_token=).+?(?=&)")
            let range = NSRange(location: 0, length: string.count)
            let result = regular.firstMatch(in: string, range: range)
            let some = result.map { value -> String? in
                guard let range = Range(value.range, in: string) else { return nil }
                return String(string[range])
            }
            return some ?? nil
        } catch let error {
            print(error)
        }
        return nil
    }
    
    var accessId: String? {
        return "173120078"
    }
}
