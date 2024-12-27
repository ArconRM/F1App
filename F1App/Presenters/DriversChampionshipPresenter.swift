//
//  DriversChampionshipPresenter.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 07.12.2024.
//

import Foundation

final class DriversChampionshipPresenter: Presenter {
    typealias View = DriversChampionshipViewController

    let standingsNetworkService: StandingsNetworkService
    weak var view: View?

    init(standingsNetworkService: StandingsNetworkService) {
        self.standingsNetworkService = standingsNetworkService
    }

    func viewDidLoad() {
        loadDriversChampionship()
    }

    private func loadDriversChampionship() {
        standingsNetworkService.fetchCurrentDriversChampionship(resultQueue: .main) { result in
            switch result {
            case .success(let driversChampionship):
                self.view?.loadedDriversChampionship(driversChampionship)
            case .failure(let error):
                print(error)
            }
        }
    }
}
