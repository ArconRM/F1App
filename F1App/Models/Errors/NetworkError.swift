//
//  NetworkError.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 22.11.2024.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case urlError
    case fetchError(String)
    case unexpectedError(String)

    public var errorDescription: String? {
        switch self {
        case .urlError:
            return "Неправильная ссылка"
        case .fetchError:
            return "Ошибка при получении данных"
        case .unexpectedError:
            return "Неожиданная ошибка"
        }
    }

    public var failureReason: String? {
        switch self {
        case .urlError:
            return "Вызвался запрос по кривой ссылке."
        case .fetchError(let error):
            return "Не удалось получить данные с сайта. Ошибка: \(error)."
        case .unexpectedError(let error):
            return "Неожиданная ошибка при получении данных с сайта. Ошибка: \(error)."
        }
    }
}
