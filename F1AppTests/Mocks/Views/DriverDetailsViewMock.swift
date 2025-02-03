//
//  DriverDetailsViewMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.02.2025.
//

import Foundation

class DriverDetailsViewMock: DriverDetailsPresentable {
    var driver: Driver?
    var currentError: (any Error)?
    
    func loadedDriverDetails(_ driver: Driver) {
        self.driver = driver
    }
    
    func showNetworkError(_ error: any Error) {
        currentError = error
    }
}
