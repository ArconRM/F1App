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
                self?.view?.loadedAllRaces(races: self?.sortRaces(races) ?? [])
            case .failure:
                fatalError("Failed to load races")
            }
        }
    }
    
    /// Moves races without winnerId forward
    private func sortRaces(_ races: [ChampionshipRace?]) -> [ChampionshipRace?] {
        return races.filter { $0?.winnerId == nil } + races.filter { $0?.winnerId != nil }
    }
}
