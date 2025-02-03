//
//  SchedulePresenter.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 07.12.2024.
//

import Foundation

final class SchedulePresenter: Presenter {
    typealias View = SchedulePresentable

    private let raceNetworkService: RacesNetworkService

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
                self?.view?.loadedNextRace(race)
            case .failure(let error):
                self?.view?.showNetworkError(error)
            }
        }
    }

    private func loadAllRaces() {
        raceNetworkService.fetchSeasonRaces(year: 2024, resultQueue: .main) { [weak self] result in
            switch result {
            case .success(let races):
                self?.view?.loadedAllRaces(self?.sortRaces(races) ?? [])
            case .failure(let error):
                self?.view?.showNetworkError(NetworkError.fetchError(error.localizedDescription))
            }
        }
    }

    /// Moves races without winnerId forward
    private func sortRaces(_ races: [Round?]) -> [Round?] {
        return races.filter { $0?.winner?.driverId == nil } + races.filter { $0?.winner?.driverId != nil }
    }
}
