//
//  StandingsNetworkServiceMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 24.12.2024.
//

import Foundation

struct StandingsNetworkServiceMock: StandingsNetworkService {
    private let driversChampionshipDecoder: DriversChampionshipDecoderF1Connect
    private let constructorsChampionshipDecoder: ConstructorsChampionshipDecoderF1Connect

    init() {
        let driverDecoder = DriverDecoderF1Connect()
        let teamDecoder = TeamDecoderF1Connect()

        driversChampionshipDecoder = DriversChampionshipDecoderF1Connect(driverDecoder: driverDecoder, teamDecoder: teamDecoder)
        constructorsChampionshipDecoder = ConstructorsChampionshipDecoderF1Connect(teamDecoder: teamDecoder)
    }

    func fetchDriversChampionship(
        year: Int? = nil,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[DriversChampionshipEntry?], any Error>) -> Void
    ) {
        if let path = Bundle.main.path(forResource: "drivers-championship", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let championship = try driversChampionshipDecoder.decodeDriversChampionship(from: data)
                completionHandler(.success(championship))
            } catch let error {
                completionHandler(.failure(error))
            }
        }
    }

    func fetchConstructorsChampionship(
        year: Int? = nil,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[ConstructorsChampionshipEntry?], any Error>) -> Void
    ) {
        if let path = Bundle.main.path(forResource: "constructors-championship", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let championship = try constructorsChampionshipDecoder.decodeConstructorsChampionship(from: data)
                completionHandler(.success(championship))
            } catch let error {
                completionHandler(.failure(error))
            }
        }
    }

}
