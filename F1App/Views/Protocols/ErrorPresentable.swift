//
//  ErrorPresentable.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 01.02.2025.
//

import Foundation
import UIKit

protocol ErrorPresentable {
    func showNetworkError(_ error: Error)
}

extension ErrorPresentable where Self: UIViewController {
    func showNetworkError(_ error: Error) {
        let errorToShow: LocalizedError

        if let networkError = error as? NetworkError {
            errorToShow = networkError

        } else if let serializationError = error as? SerializationError {
            errorToShow = serializationError

        } else {
            errorToShow = NetworkError.unexpectedError(error.localizedDescription)
        }

        print(errorToShow)

        let alert = UIAlertController(title: errorToShow.errorDescription, message: errorToShow.failureReason, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
