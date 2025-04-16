//
//  NetworkError.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 22.11.2024.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case urlError
    case fetchError(String)
    case parserError(String)
    case unexpectedError(String)
    case multipleErrors([any Error])

    var errorDescription: String? {
        switch self {
        case .urlError:
            return "Неправильная ссылка"
        case .parserError:
            return "Ошибка парсинга данных"
        case .fetchError:
            return "Ошибка при получении данных"
        case .unexpectedError:
            return "Неожиданная ошибка"
        case .multipleErrors:
            return "Множество ошибок"
        }
    }

    var failureReason: String? {
        switch self {
        case .urlError:
            return "Вызвался запрос по кривой ссылке."
        case .parserError(let error):
            return "Не удалось спарсить данные. \(error)."
        case .fetchError(let error):
            return "Не удалось получить данные с API. Ошибка: \(error)."
        case .unexpectedError(let error):
            return "Неизвестная ошибка при получении данных с API. Ошибка: \(error)."
        case .multipleErrors(let errors):
            return "При получении данных с API случилось несколько ошибок: \(errors.count)"
        }
    }
}
