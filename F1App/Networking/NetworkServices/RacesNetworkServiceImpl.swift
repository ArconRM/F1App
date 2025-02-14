//
//  RacesNetworkServiceImpl.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 22.11.2024.
//

import Foundation

struct RacesNetworkServiceImpl: RacesNetworkService {

    private let urlSource: UrlSource
    private let raceDecoder: RaceDecoder

    init(urlSource: UrlSource, raceDecoder: RaceDecoder) {
        self.urlSource = urlSource
        self.raceDecoder = raceDecoder
    }

    func fetchNextSeasonRace(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<Round?, any Error>) -> Void
    ) {
        let nextSeasonRaceUrl = urlSource.getNextSeasonRaceUrl()

        URLSession.shared.dataTask(with: nextSeasonRaceUrl) { data, _, error in
            guard error == nil else {
                resultQueue.async { completionHandler(.failure(NetworkError.fetchError(error!.localizedDescription))) }
                return
            }

            guard data != nil else {
                resultQueue.async { completionHandler(.success(nil)) }
                return
            }

            do {
                let race = try self.raceDecoder.decodeRace(from: data!)
                resultQueue.async { completionHandler(.success(race)) }
            } catch let error {
                resultQueue.async { completionHandler(.failure(NetworkError.parserError(error.localizedDescription))) }
            }
        }.resume()
    }

    func fetchSeasonRaces(
        year: Int?,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[Round?], any Error>) -> Void
    ) {
        let seasonRacesUrl = urlSource.getSeasonRacesUrl(year: year)

        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        config.requestCachePolicy = .useProtocolCachePolicy
        let session = URLSession(configuration: config)

        session.dataTask(with: seasonRacesUrl) { data, _, error in
            guard error == nil else {
                resultQueue.async { completionHandler(.failure(NetworkError.fetchError(error!.localizedDescription))) }
                return
            }

            guard data != nil else {
                resultQueue.async { completionHandler(.success([])) }
                return
            }

            do {
                let races = try self.raceDecoder.decodeRaces(from: data!)
                resultQueue.async { completionHandler(.success(races)) }
            } catch let error {
                resultQueue.async { completionHandler(.failure(NetworkError.parserError(error.localizedDescription))) }
            }
        }.resume()
    }
}
