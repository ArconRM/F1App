//
//  DependencyFactoryMock.swift
//  F1AppTests
//
//  Created by Artemiy MIROTVORTSEV on 02.02.2025.
//

import Foundation
@testable import F1App

class DependencyFactoryMock {
    func makeScheduleViewMock() -> SchedulePresentable {
        let raceNetworkService = RacesNetworkServiceMock()
        let presenter = SchedulePresenter(raceNetworkService: raceNetworkService)
        
        let view = ScheduleViewMock()
        presenter.view = view
        return view
    }

    func makeRoundDetailsViewMock(round: Round) -> RoundDetailsPresentable {
        let presenter = RoundDetailsPresenter(round: round, roundResultsNetworkService: RoundResultsNetworkServiceMock())
        
        let view = RoundDetailsViewMock()
        presenter.view = view
        return view
    }

    func makeDriversChampionshipViewMock() -> DriversChampionshipPresentable {
        let standingsNetworkService = StandingsNetworkServiceMock()
        let presenter = DriversChampionshipPresenter(standingsNetworkService: standingsNetworkService)
        
        let view = DriversChampionshipViewMock()
        presenter.view = view
        return view
    }

    func makeDriverDetailsViewMock(driver: Driver) -> DriverDetailsPresentable {
        let presenter = DriverDetailsPresenter(driver: driver)
        
        let view = DriverDetailsViewMock()
        presenter.view = view
        return view
    }

    func makeConstructorChampionshipViewMock() -> ConstructorsChampionshipPresentable {
        let standingsNetworkService = StandingsNetworkServiceMock()
        let presenter = ConstructorsChampionshipPresenter(standingsNetworkService: standingsNetworkService)
        
        let view = ConstructorsChampionshipViewMock()
        presenter.view = view
        return view
    }

    func makeTeamDetailsViewMock(team: Team) -> TeamDetailsPresentable {
        let presenter = TeamDetailsPresenter(team: team)
        
        let view = TeamDetailsViewMock()
        presenter.view = view
        return view
    }
}
