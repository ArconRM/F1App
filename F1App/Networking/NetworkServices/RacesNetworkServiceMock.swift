//
//  RacesNetworkServiceMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 10.12.2024.
//

import Foundation

public struct RacesNetworkServiceMock: RacesNetworkService {
    
    public func fetchCurrentSeasonRaces(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[ChampionshipRace?], any Error>) -> Void
    ) {
        completionHandler(.success([ChampionshipRace.mock, ChampionshipRace.mock]))
    }
    
    public func fetchNextSeasonRace(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<ChampionshipRace?, any Error>) -> Void
    ) {
        completionHandler(.success(ChampionshipRace.mock))
    }
}
