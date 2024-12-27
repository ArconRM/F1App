//
//  StandingsNetworkServiceImpl.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 25.12.2024.
//

import Foundation

struct StandingsNetworkServiceImpl: StandingsNetworkService {
    private let urlSource: UrlSource
    private let driversChampionshipDecoder: DriversChampionshipDecoder

    init (urlSource: UrlSource, driversChampionshipDecoder: DriversChampionshipDecoder) {
        self.urlSource = urlSource
        self.driversChampionshipDecoder = driversChampionshipDecoder
    }

    func fetchCurrentDriversChampionship(resultQueue: DispatchQueue, completionHandler: @escaping (Result<[DriversChampionshipEntry?], any Error>) -> Void) {
        fatalError("Not implemented")
    }
    
    func fetchCurrentConstructorsChampionship(resultQueue: DispatchQueue, completionHandler: @escaping (Result<[ConstructorsChampionshipEntry?], any Error>) -> Void) {
        fatalError("Not implemented")
    }
}
