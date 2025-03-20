//
//  StandingsNetworkServiceAlamofire.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 20.03.2025.
//

import Foundation
import Alamofire

struct StandingsNetworkServiceAlamofire: StandingsNetworkService {
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

        AF.request(driversChampionshipUrl).response { response in
            switch response.result {
            case .success(let data):
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

            case .failure(let error):
                resultQueue.async { completionHandler(.failure(error)) }
            }
        }
    }

    func fetchConstructorsChampionship(
        year: Int?,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[ConstructorsChampionshipEntry?], any Error>) -> Void
    ) {
        let constructorsChampionshipUrl = urlSource.getConstructorsChampionshipUrl(year: year)

        AF.request(constructorsChampionshipUrl).response { response in
            switch response.result {
            case .success(let data):
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

            case .failure(let error):
                resultQueue.async { completionHandler(.failure(error)) }
            }
        }
    }
}
