//
//  F1ConnectFactory.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 03.12.2024.
//

import Foundation
import UIKit

final class F1ConnectFactory: Factory {
    private let urlSource = UrlSourceF1Connect()
    private let raceDecoder = F1ConnectRaceDecoder()

    func makeScheduleViewController() -> ScheduleViewController {
        let racesNetworkService = RacesNetworkServiceImpl(urlSource: urlSource, raceDecoder: raceDecoder)
        let presenter = SchedulePresenter(raceNetworkService: racesNetworkService)
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
