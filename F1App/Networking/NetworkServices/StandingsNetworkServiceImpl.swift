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
    private let constructorsChampionshipDecoder: ConstructorsChampionshipDecoder

    init (urlSource: UrlSource, driversChampionshipDecoder: DriversChampionshipDecoder, constructorsChampionshipDecoder: ConstructorsChampionshipDecoder) {
        self.urlSource = urlSource
        self.driversChampionshipDecoder = driversChampionshipDecoder
        self.constructorsChampionshipDecoder = constructorsChampionshipDecoder
    }

    func fetchCurrentDriversChampionship(resultQueue: DispatchQueue, completionHandler: @escaping (Result<[DriversChampionshipEntry?], any Error>) -> Void) {
        fatalError("Not implemented")
    }
    
    func fetchCurrentConstructorsChampionship(resultQueue: DispatchQueue, completionHandler: @escaping (Result<[ConstructorsChampionshipEntry?], any Error>) -> Void) {
        fatalError("Not implemented")
    }
}
