//
//  DriverDetailsPresenter.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 04.01.2025.
//

import Foundation

class DriverDetailsPresenter: Presenter {
    typealias View = DriverDetailsViewController

    var driver: Driver
    weak var view: View?

    init(driver: Driver) {
        self.driver = driver
    }

    func viewDidLoad() {
        self.view?.loadedDriverDetails(driver: driver)
    }
}
