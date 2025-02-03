//
//  DriversChampionshipViewMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.02.2025.
//

import Foundation

class DriversChampionshipViewMock: DriversChampionshipPresentable {
    var driversChampionship: [DriversChampionshipEntry?]?
    var currentError: (any Error)?
    
    func loadedDriversChampionship(_ driversChampionship: [DriversChampionshipEntry?]) {
        self.driversChampionship = driversChampionship
    }
    
    func showNetworkError(_ error: any Error) {
        currentError = error
    }
}
