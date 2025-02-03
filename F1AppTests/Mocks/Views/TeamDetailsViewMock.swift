//
//  TeamDetailsViewMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.02.2025.
//

import Foundation

class TeamDetailsViewMock: TeamDetailsPresentable {
    var team: Team?
    var currentError: (any Error)?
    
    func loadedTeamDetails(_ team: Team) {
        self.team = team
    }
    
    func showNetworkError(_ error: any Error) {
        currentError = error
    }
}
