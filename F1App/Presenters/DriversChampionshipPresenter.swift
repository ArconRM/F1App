//
//  DriversChampionshipPresenter.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 07.12.2024.
//

import Foundation

final class DriversChampionshipPresenter: Presenter {
    typealias View = DriversChampionshipViewController

    let driversChampionshipNetworkService: StandingsNetworkService
    weak var view: View?

    init(driversChampionshipNetworkService: StandingsNetworkService) {
        self.driversChampionshipNetworkService = driversChampionshipNetworkService
    }

    func viewDidLoad() {
        loadDriversChampionship()
    }

    private func loadDriversChampionship() {
        driversChampionshipNetworkService.fetchCurrentDriversChampionship(resultQueue: .main) { result in
            switch result {
            case .success(let driversChampionship):
                self.view?.loadedDriversChampionship(driversChampionship)
            case .failure(let error):
                print(error)
            }
        }
    }
}
