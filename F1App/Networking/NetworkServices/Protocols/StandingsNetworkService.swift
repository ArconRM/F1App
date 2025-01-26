//
//  StandingsNetworkService.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 19.11.2024.
//

import Foundation

protocol StandingsNetworkService {

    func fetchDriversChampionship(
        year: Int?,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[DriversChampionshipEntry?], Error>) -> Void
    )

    func fetchConstructorsChampionship(
        year: Int?,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[ConstructorsChampionshipEntry?], Error>) -> Void
    )

}
