//
//  Presenter.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation

protocol Presenter {
    associatedtype View: BaseViewController

    var view: View? { get set }

    func viewDidLoad()

}
