//
//  ScheduleViewMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.02.2025.
//

import Foundation

class ScheduleViewMock: SchedulePresentable {
    
    var nextRace: Round?
    var currentSeasonRaces: [Round?]?
    var prevSeasonRaces: [Round?]?
    var currentError: (any Error)?
    
    func loadedNextRace(_ round: Round?) {
        nextRace = round
    }
    
    func loadedCurrentSeasonRaces(_ races: [Round?]) {
        currentSeasonRaces = races
    }
    
    func loadedPrevSeasonRaces(_ races: [Round?]) {
        prevSeasonRaces = races
    }
    
    func showNetworkError(_ error: any Error) {
        currentError = error
    }
}
