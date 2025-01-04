//
//  BaseViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation
import UIKit

// TODO: Добавить общий интерфейс для ошибок
class BaseViewController: UIViewController {
    let presenter: any Presenter

    init(presenter: any Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
