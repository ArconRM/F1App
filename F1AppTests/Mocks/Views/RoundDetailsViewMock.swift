//
//  RoundDetailsViewMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.02.2025.
//

import Foundation

class RoundDetailsViewMock: RoundDetailsPresentable {
    var baseRoundInfo: Round?
    var roundResultsInfo: RoundResults?
    var currentError: (any Error)?
    
    func loadedBaseRoundInfo(_ round: Round) {
        baseRoundInfo = round
    }
    
    func loadedRoundResultsInfo(_ roundResults: RoundResults) {
        roundResultsInfo = roundResults
    }
    
    func showNetworkError(_ error: any Error) {
        currentError = error
    }
}
