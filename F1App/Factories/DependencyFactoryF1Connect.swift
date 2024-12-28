//
//  DependencyFactoryF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 03.12.2024.
//

import Foundation
import UIKit

final class DependencyFactoryF1Connect: DependencyFactory {
    private let urlSource = UrlSourceF1Connect()
    private let raceDecoder = RaceDecoderF1Connect()
    private var driverDecoder = DriverDecoderF1Connect()
    private var teamDecoder = TeamDecoderF1Connect()
    private lazy var driversChampionshipDecoder = DriversChampionshipDecoderF1Connect(driverDecoder: driverDecoder, teamDecoder: teamDecoder)
    private lazy var constructorsChampionshipDecoder = ConstructorsChampionshipDecoderF1Connect(teamDecoder: teamDecoder)

    func makeScheduleViewController() -> ScheduleViewController {
        let racesNetworkService = RacesNetworkServiceImpl(urlSource: urlSource, raceDecoder: raceDecoder)
        let presenter = SchedulePresenter(raceNetworkService: racesNetworkService)
        let viewController = ScheduleViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeDriversChampionshipViewController() -> DriversChampionshipViewController {
        let standingsNetworkService = StandingsNetworkServiceImpl(urlSource: urlSource, driversChampionshipDecoder: driversChampionshipDecoder)
        let presenter = DriversChampionshipPresenter(standingsNetworkService: standingsNetworkService)
        let viewController = DriversChampionshipViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeConstructorChampionshipViewController() -> ConstructorsChampionshipViewController {
        let standingsNetworkService = StandingsNetworkServiceImpl(urlSource: urlSource, driversChampionshipDecoder: driversChampionshipDecoder)
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
