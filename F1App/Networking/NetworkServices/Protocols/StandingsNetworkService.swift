//
//  StandingsNetworkService.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 19.11.2024.
//

import Foundation

protocol StandingsNetworkService {

    func fetchCurrentDriversChampionship(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[DriversChampionshipEntry?], Error>) -> Void
    )
}
