//
//  ConstructorChampionship.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 07.12.2024.
//

import Foundation

final class ConstructorChampionshipPresenter: Presenter {
    typealias View = ConstructorsChampionshipViewController

    private let standingsNetworkService: StandingsNetworkService

    weak var view: View?

    init(standingsNetworkService: StandingsNetworkService) {
        self.standingsNetworkService = standingsNetworkService
    }

    func viewDidLoad() {
        loadConstructorsChampionship()
    }

    private func loadConstructorsChampionship() {
        standingsNetworkService.fetchConstructorsChampionship(year: nil, resultQueue: .main) { [weak self] result in
            switch result {
            case .success(let constructorsdriversChampionship):
                self?.view?.loadedConstructorsChampionship(constructorsdriversChampionship)
            case .failure(let error):
                self?.view?.showNetworkError(error)
            }
        }
    }
}
