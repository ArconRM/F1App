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
    private let driverDecoder = DriverDecoderF1Connect()
    private let teamDecoder = TeamDecoderF1Connect()
    private let circuitDecoder = CircuitDecoderF1Connect()

    private lazy var raceDecoder = RaceDecoderF1Connect(circuitDecoder: circuitDecoder, driverDecoder: driverDecoder, teamDecoder: teamDecoder)
    private lazy var driversChampionshipDecoder = DriversChampionshipDecoderF1Connect(driverDecoder: driverDecoder, teamDecoder: teamDecoder)
    private lazy var constructorsChampionshipDecoder = ConstructorsChampionshipDecoderF1Connect(teamDecoder: teamDecoder)
    private lazy var practiceResultsDecoder = PracticeResultDecoderF1Connect(driverDecoder: driverDecoder, teamDecoder: teamDecoder)
    private lazy var qualyResultsDecoder = QualyResultDecoderF1Connect(driverDecoder: driverDecoder, teamDecoder: teamDecoder)
    private lazy var raceResultsDecoder = RaceResultDecoderF1Connect(driverDecoder: driverDecoder, teamDecoder: teamDecoder)

    func makeScheduleViewController() -> ScheduleViewController {
        let racesNetworkService = RacesNetworkServiceImpl(urlSource: urlSource, raceDecoder: raceDecoder)
        let presenter = SchedulePresenter(raceNetworkService: racesNetworkService)

        let viewController = ScheduleViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeRoundDetailsViewController(round: Round) -> RoundDetailsViewController {
        let roundResultsNetworkService = RoundResultsNetworkServiceImpl(
            urlSource: urlSource,
            practiceResultDecoder: practiceResultsDecoder,
            qualyResultDecoder: qualyResultsDecoder,
            raceResultDecoder: raceResultsDecoder
        )

        let presenter = RoundDetailsPresenter(round: round, roundResultsNetworkService: roundResultsNetworkService)

        let viewController = RoundDetailsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeDriversChampionshipViewController() -> DriversChampionshipViewController {
        let standingsNetworkService = StandingsNetworkServiceImpl(
            urlSource: urlSource,
            driversChampionshipDecoder: driversChampionshipDecoder,
            constructorsChampionshipDecoder: constructorsChampionshipDecoder
        )

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
        let standingsNetworkService = StandingsNetworkServiceImpl(
            urlSource: urlSource,
            driversChampionshipDecoder: driversChampionshipDecoder,
            constructorsChampionshipDecoder: constructorsChampionshipDecoder
        )

        let presenter = ConstructorChampionshipPresenter(standingsNetworkService: standingsNetworkService)

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
