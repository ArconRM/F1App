//
//  DependencyFactoryMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 10.12.2024.
//

import Foundation

final class DependencyFactoryMock: DependencyFactory {

    func makeScheduleViewController() -> ScheduleViewController {
        let raceNetworkService = RacesNetworkServiceMock()
        let presenter = SchedulePresenter(raceNetworkService: raceNetworkService)
        let viewController = ScheduleViewController(presenter: presenter)
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

    func makeConstructorChampionshipViewController() -> ConstructorsChampionshipViewController {
        let standingsNetworkService = StandingsNetworkServiceMock()
        let presenter = ConstructorChampionshipPresenter(standingsNetworkService: standingsNetworkService)
        let viewController = ConstructorsChampionshipViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeSettingsViewController() -> SettingsViewController {
        let presenter = SettingsPresenter()
        let viewController = SettingsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
    
    func makeRoundDetailsViewController(round: Round) -> RoundDetailsViewController {
        let presenter = RoundDetailsPresenter(round: round)
        let viewController = RoundDetailsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
