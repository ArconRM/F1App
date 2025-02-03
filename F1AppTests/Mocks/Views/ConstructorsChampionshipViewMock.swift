//
//  ConstructorsChampionshipViewMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.02.2025.
//

import Foundation

class ConstructorsChampionshipViewMock: ConstructorsChampionshipPresentable {
    var constructorsChampionship: [ConstructorsChampionshipEntry?]?
    var currentError: (any Error)?
    
    func loadedConstructorsChampionship(_ constructorsChampionship: [ConstructorsChampionshipEntry?]) {
        self.constructorsChampionship = constructorsChampionship
    }
    
    func showNetworkError(_ error: any Error) {
        currentError = error
    }
}
