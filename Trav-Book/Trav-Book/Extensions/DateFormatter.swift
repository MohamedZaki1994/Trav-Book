//
//  DateFormatter.swift
//  Trav-Book
//
//  Created by Mohamed Zaki on 10/9/20.
//  Copyright © 2020 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}

extension Double {
    func timeAgo() -> String {
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour , .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        return String(format: formatter.string(from: date, to: Date()) ?? "", locale: .current) + " ago"
    }
}
