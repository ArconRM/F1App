//
//  RacesNetworkServiceMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 10.12.2024.
//

import Foundation

struct RacesNetworkServiceMock: RacesNetworkService {
    private let raceDecoder = RaceDecoderF1Connect()

    func fetchNextSeasonRace(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<ChampionshipRace?, any Error>) -> Void
    ) {
        if let path = Bundle.main.path(forResource: "current", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let races = try raceDecoder.decodeRaces(from: data)
                completionHandler(.success(races[22]))
            } catch let error {
                completionHandler(.failure(NetworkError.fetchError(error.localizedDescription)))
            }
        }
    }

    func fetchCurrentSeasonRaces(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[ChampionshipRace?], any Error>) -> Void
    ) {
        if let path = Bundle.main.path(forResource: "current", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let races = try raceDecoder.decodeRaces(from: data)
                completionHandler(.success(races))
            } catch let error {
                completionHandler(.failure(NetworkError.fetchError(error.localizedDescription)))
            }
        }
    }
}
