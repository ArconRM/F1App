//
//  MockFactory.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 10.12.2024.
//

import Foundation

final class MockFactory: Factory {

    func makeScheduleViewController() -> ScheduleViewController {
        let raceNetworkService = RacesNetworkServiceMock()
        let presenter = SchedulePresenter(raceNetworkService: raceNetworkService)
        let viewController = ScheduleViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeDriversChampionshipViewController() -> DriversChampionshipViewController {
        let presenter = DriversChampionshipPresenter()
        let viewController = DriversChampionshipViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeConstructorChampionshipViewController() -> ConstructorChampionshipViewController {
        let presenter = ConstructorChampionshipPresenter()
        let viewController = ConstructorChampionshipViewController(presenter: presenter)
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
