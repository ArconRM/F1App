//
//  Date+Extensions.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 09.12.2024.
//

import Foundation

extension Date {

    static func fromStringWithFormat(from dateString: String, format dateFormat: String) -> Self? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: dateString) ?? nil
    }

    static func fromStringWithFormat(from dateString: String, formatVariants dateFormats: [String]) -> Self? {
        let dateFormatter = DateFormatter()

        for dateFormat in dateFormats {
            dateFormatter.dateFormat = dateFormat
            if let date = dateFormatter.date(from: dateString) {
                return date
            }
        }

        return nil
    }

    func getHours() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return Int(dateFormatter.string(from: self)) ?? 0
    }

    func getMinutes() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        return Int(dateFormatter.string(from: self)) ?? 0
    }

    func getDayMonthString(divider: String = " ") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d\(divider)MMMM"
        return dateFormatter.string(from: self)
    }

    func getDayMonthTimeWordString(divider: String = " ") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d\(divider)MMMM\(divider)HH:mm"
        return dateFormatter.string(from: self)
    }

    func isPassed() -> Bool {
        return Date() > Calendar.current.date(byAdding: .hour, value: 2, to: self)!
    }
}