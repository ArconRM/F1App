//
//  DriversChampionshipPresenter.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 07.12.2024.
//

import Foundation

final class DriversChampionshipPresenter: Presenter {
    typealias View = DriversChampionshipPresentable

    private let standingsNetworkService: StandingsNetworkService

    weak var view: View?

    init(standingsNetworkService: StandingsNetworkService) {
        self.standingsNetworkService = standingsNetworkService
    }

    func viewDidLoad() {
        loadDriversChampionship(year: Int(Constants.availableSeasons[0]) ?? -1)
    }

    func handleSeasonSelectionChange(year: Int?) {
        loadDriversChampionship(year: year)
    }

    private func loadDriversChampionship(year: Int?) {
        standingsNetworkService.fetchDriversChampionship(year: year, resultQueue: .main) { [weak self] result in
            switch result {
            case .success(let driversChampionship):
                self?.view?.loadedDriversChampionship(driversChampionship)
            case .failure(let error):
                self?.view?.showNetworkError(error)
            }
        }
    }
}
