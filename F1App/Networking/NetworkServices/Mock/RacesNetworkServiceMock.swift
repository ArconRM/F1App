//
//  RacesNetworkServiceMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 10.12.2024.
//

import Foundation

public struct RacesNetworkServiceMock: RacesNetworkService {
    
    private let raceDecoder = F1ConnectRaceDecoder()

    public func fetchNextSeasonRace(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<ChampionshipRace?, any Error>) -> Void
    ) {
        if let path = Bundle.main.path(forResource: "current", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let races = try raceDecoder.decodeRaces(from: data)
                completionHandler(.success(races[22]))
            }
            catch let error {
                completionHandler(.failure(NetworkError.fetchError(error.localizedDescription)))
            }
        }
    }

    public func fetchCurrentSeasonRaces(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[ChampionshipRace?], any Error>) -> Void
    ) {
        if let path = Bundle.main.path(forResource: "current", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let races = try raceDecoder.decodeRaces(from: data)
                completionHandler(.success(races))
            }
            catch let error {
                completionHandler(.failure(NetworkError.fetchError(error.localizedDescription)))
            }
        }
    }
}
