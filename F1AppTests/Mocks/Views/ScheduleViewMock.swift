//
//  ScheduleViewMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.02.2025.
//

import Foundation

class ScheduleViewMock: SchedulePresentable {
    var nextRace: Round?
    var allRaces: [Round?]?
    var currentError: (any Error)?
    
    func loadedNextRace(_ round: Round?) {
        nextRace = round
    }
    
    func loadedAllRaces(_ races: [Round?]) {
        allRaces = races
    }
    
    func showNetworkError(_ error: any Error) {
        currentError = error
    }
}
