//
//  BaseViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    let presenter: any Presenter

    init(presenter: any Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
