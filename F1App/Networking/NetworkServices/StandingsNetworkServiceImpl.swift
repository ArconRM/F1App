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

    init(
        urlSource: UrlSource,
        driversChampionshipDecoder: DriversChampionshipDecoder,
        constructorsChampionshipDecoder: ConstructorsChampionshipDecoder
    ) {
        self.urlSource = urlSource
        self.driversChampionshipDecoder = driversChampionshipDecoder
        self.constructorsChampionshipDecoder = constructorsChampionshipDecoder
    }

    func fetchDriversChampionship(
        year: Int?,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[DriversChampionshipEntry?], any Error>) -> Void
    ) {
        let driversChampionshipUrl = urlSource.getDriversChampionshipUrl(year: year)

        URLSession.shared.dataTask(with: driversChampionshipUrl) { data, _, error in
            guard error == nil else {
                resultQueue.async { completionHandler(.failure(error!)) }
                return
            }

            guard data != nil else {
                resultQueue.async { completionHandler(.success([])) }
                return
            }

            do {
                let championship = try driversChampionshipDecoder.decodeDriversChampionship(from: data!)
                resultQueue.async { completionHandler(.success(championship)) }
            } catch let error {
                resultQueue.async { completionHandler(.failure(NetworkError.parserError(error.localizedDescription))) }
            }
        }.resume()
    }

    func fetchConstructorsChampionship(
        year: Int?,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[ConstructorsChampionshipEntry?], any Error>) -> Void
    ) {
        let constructorsChampionshipUrl = urlSource.getConstructorsChampionshipUrl(year: year)

        URLSession.shared.dataTask(with: constructorsChampionshipUrl) { data, _, error in
            guard error == nil else {
                resultQueue.async { completionHandler(.failure(error!)) }
                return
            }

            guard data != nil else {
                resultQueue.async { completionHandler(.success([])) }
                return
            }

            do {
                let championship = try constructorsChampionshipDecoder.decodeConstructorsChampionship(from: data!)
                resultQueue.async { completionHandler(.success(championship)) }
            } catch let error {
                resultQueue.async { completionHandler(.failure(NetworkError.parserError(error.localizedDescription))) }
            }
        }.resume()
    }
}
