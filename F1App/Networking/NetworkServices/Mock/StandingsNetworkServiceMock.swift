//
//  StandingsNetworkServiceMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 24.12.2024.
//

import Foundation

struct StandingsNetworkServiceMock: StandingsNetworkService {
    private let driversChampionshipDecoder = DriversChampionshipDecoderF1Connect(driverDecoder: DriverDecoderF1Connect(), teamDecoder: TeamDecoderF1Connect())

    func fetchCurrentDriversChampionship(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[DriversChampionshipEntry?], any Error>) -> Void
    ) {
        if let path = Bundle.main.path(forResource: "drivers-championship", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let championship = try driversChampionshipDecoder.decodeDriversChampionship(data)
                completionHandler(.success(championship))
            } catch let error {
                completionHandler(.failure(NetworkError.fetchError(error.localizedDescription)))
            }
        }
    }
}
