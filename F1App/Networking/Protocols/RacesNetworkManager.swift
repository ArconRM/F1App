//
//  RacesNetworkManager.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 20.11.2024.
//

import Foundation

public protocol RacesNetworkManager {
    func fetchCurrentSeasonRaces(
        resultQueue: DispatchQueue,
        completionHandler: @escaping(Result<[ChampionshipRace], Error>) -> Void
    )
    
    func fetchNextSeasonRace(
        resultQueue: DispatchQueue,
        completionHandler: @escaping(Result<ChampionshipRace, Error>) -> Void
    )
}
