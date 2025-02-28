//
//  ConstructorChampionship.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 07.12.2024.
//

import Foundation

final class ConstructorsChampionshipPresenter: Presenter {
    typealias View = ConstructorsChampionshipPresentable

    private let standingsNetworkService: StandingsNetworkService

    weak var view: View?

    init(standingsNetworkService: StandingsNetworkService) {
        self.standingsNetworkService = standingsNetworkService
    }

    func viewDidLoad() {
        loadConstructorsChampionship(year: Int(Constants.availableSeasons[0]) ?? -1)
    }

    func handleSeasonSelectionChange(year: Int?) {
        loadConstructorsChampionship(year: year)
    }

    private func loadConstructorsChampionship(year: Int?) {
        standingsNetworkService.fetchConstructorsChampionship(year: year, resultQueue: .main) { [weak self] result in
            switch result {
            case .success(let constructorsdriversChampionship):
                self?.view?.loadedConstructorsChampionship(constructorsdriversChampionship)
            case .failure(let error):
                self?.view?.showNetworkError(error)
            }
        }
    }
}
