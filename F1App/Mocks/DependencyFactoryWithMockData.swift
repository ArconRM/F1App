//
//  DependencyFactoryWithMockData.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 10.12.2024.
//

import Foundation

final class DependencyFactoryWithMockData: DependencyFactory {

    func makeScheduleViewController() -> ScheduleViewController {
        let raceNetworkService = RacesNetworkServiceMock()
        let presenter = SchedulePresenter(raceNetworkService: raceNetworkService)
        let viewController = ScheduleViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeRoundDetailsViewController(round: Round) -> RoundDetailsViewController {
        let presenter = RoundDetailsPresenter(round: round, roundResultsNetworkService: RoundResultsNetworkServiceMock())
        let viewController = RoundDetailsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeDriversChampionshipViewController() -> DriversChampionshipViewController {
        let standingsNetworkService = StandingsNetworkServiceMock()
        let presenter = DriversChampionshipPresenter(standingsNetworkService: standingsNetworkService)
        let viewController = DriversChampionshipViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeDriverDetailsViewController(driver: Driver) -> DriverDetailsViewController {
        let presenter = DriverDetailsPresenter(driver: driver)
        let viewController = DriverDetailsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeConstructorChampionshipViewController() -> ConstructorsChampionshipViewController {
        let standingsNetworkService = StandingsNetworkServiceMock()
        let presenter = ConstructorsChampionshipPresenter(standingsNetworkService: standingsNetworkService)
        let viewController = ConstructorsChampionshipViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeTeamDetailsViewController(team: Team) -> TeamDetailsViewController {
        let presenter = TeamDetailsPresenter(team: team)
        let viewController = TeamDetailsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeSettingsViewController() -> SettingsViewController {
        let presenter = SettingsPresenter()
        let viewController = SettingsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
