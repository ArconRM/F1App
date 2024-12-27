//
//  RacesNetworkService.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 20.11.2024.
//

import Foundation

protocol RacesNetworkService {

    func fetchNextSeasonRace(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<Round?, Error>) -> Void
    )

    func fetchCurrentSeasonRaces(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[Round?], Error>) -> Void
    )
}
