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
    }
    
    private func loadNextRace() {
        raceNetworkService.fetchNextSeasonRace(resultQueue: .main) { [weak self] result in
            switch result {
            case .success(let race):
                self?.view?.loadedRace(race: race)
            case .failure:
                fatalError("Failed to load races")
            }
        }
    }
}
