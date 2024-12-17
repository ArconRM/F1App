//
//  SchedulePresenter.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 07.12.2024.
//

import Foundation

final class SchedulePresenter: Presenter {
    typealias View = ScheduleViewController

    let raceNetworkService: RacesNetworkService
    weak var view: View?

    init(raceNetworkService: RacesNetworkService) {
        self.raceNetworkService = raceNetworkService
    }

    func viewDidLoad() {
        loadNextRace()
        loadAllRaces()
    }

    private func loadNextRace() {
        raceNetworkService.fetchNextSeasonRace(resultQueue: .main) { [weak self] result in
            switch result {
            case .success(let race):
                self?.view?.loadedCurrentRace(race: race)
            case .failure:
                fatalError("Failed to load race")
            }
        }
    }

    private func loadAllRaces() {
        raceNetworkService.fetchCurrentSeasonRaces(resultQueue: .main) { [weak self] result in
            switch result {
            case .success(let races):
                self?.view?.loadedAllRaces(races: races)
            case .failure:
                fatalError("Failed to load races")
            }
        }
    }
}
