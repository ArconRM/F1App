//
//  DriversNetworkService.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 19.11.2024.
//

import Foundation

public protocol DriversNetworkService {
    func fetchDriverInSeason(
        seasonYear year: Int,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[Driver], Error>) -> Void
    )

    func fetchDriversChampionship(
        seasonYear year: Int,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[Driver], Error>) -> Void
    )

    func fetchDriverResultsInSeason(
        seasonYear year: Int,
        driverId: String,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<(), Error>) -> Void
    )

    func fetchDriversInTeam(
        seasonYear year: Int,
        teamId: String,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[Driver], Error>) -> Void
    )
}
