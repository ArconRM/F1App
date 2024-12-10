//
//  SerializationError.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 22.11.2024.
//

import Foundation

// https://developer.apple.com/swift/blog/?id=37
enum SerializationError: Error, LocalizedError {
    case missing(String)
    case invalid(String)

    public var errorDescription: String? {
        return "Ошибка сериализации"
    }

    public var failureReason: String? {
        switch self {
        case .missing(let string):
            return "Не хватает свойства \(string)"
        case .invalid(let string):
            return "Свойство \(string) кривое"
        }
    }
}
