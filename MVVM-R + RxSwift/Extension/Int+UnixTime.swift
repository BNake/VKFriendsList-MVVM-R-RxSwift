//
//  Int+UnixTime.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 06/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation


extension Int {
    func getDateStringFromUnixTime(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  Locale(identifier: "ru")
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: Date(timeIntervalSince1970: Double(self)))
    }
}
