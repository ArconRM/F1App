//
//  DateExtension.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 09.12.2024.
//

import Foundation

extension Date {
    
    func getHours() -> Int {
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "HH"
        return Int(dateFormatter.string(from: self)) ?? 0
    }

    func getMinutes() -> Int {
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "mm"
        return Int(dateFormatter.string(from: self)) ?? 0
    }

    func getDayMonthTimeWordString(divider: String = " ") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "d\(divider)MMMM\(divider)HH:mm"
        return dateFormatter.string(from: self)
    }

    func isPassed() -> Bool {
        return Date() > Calendar.current.date(byAdding: .hour, value: 2, to: self)!
    }
}
