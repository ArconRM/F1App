//
//  TeamDetailsPresenter.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 04.01.2025.
//

import Foundation

final class TeamDetailsPresenter: Presenter {
    typealias View = TeamDetailsViewController

    var team: Team
    weak var view: View?

    init (team: Team) {
        self.team = team
    }

    func viewDidLoad() {
        self.view?.loadedTeamDetails(team: team)
    }
}
