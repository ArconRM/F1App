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
        loadAllCurrentSeasonRaces()
    }
    
    func handleSeasonSelectionChange(selectionIndex: Int) {
        switch selectionIndex {
        case 0:
            loadAllCurrentSeasonRaces()
        case 1:
            loadAllPrevSeasonRaces()
        default:
            return
        }
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

    private func loadAllCurrentSeasonRaces() {
        raceNetworkService.fetchSeasonRaces(year: Date().getYear(), resultQueue: .main) { [weak self] result in
            switch result {
            case .success(let races):
                self?.view?.loadedCurrentSeasonRaces(self?.sortRaces(races) ?? [])
            case .failure(let error):
                self?.view?.showNetworkError(NetworkError.fetchError(error.localizedDescription))
            }
        }
    }
    
    private func loadAllPrevSeasonRaces() {
        raceNetworkService.fetchSeasonRaces(year: Date().getYear() - 1, resultQueue: .main) { [weak self] result in
            switch result {
            case .success(let races):
                self?.view?.loadedPrevSeasonRaces(self?.sortRaces(races) ?? [])
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
