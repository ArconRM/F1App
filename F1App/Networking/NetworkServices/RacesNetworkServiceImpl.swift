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
        guard let url = URL(string: urlSource.getNextSeasonRaceUrl()) else {
            resultQueue.async {
                completionHandler(.failure(NetworkError.urlError))
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completionHandler(.failure(NetworkError.fetchError(error!.localizedDescription)))
                return
            }

            do {
                let data = try Data(contentsOf: url)
                let race = try self.raceDecoder.decodeRace(from: data)
                completionHandler(.success(race))
            } catch let error {
                completionHandler(.failure(NetworkError.fetchError(error.localizedDescription)))
            }
        }.resume()
    }

    func fetchCurrentSeasonRaces(
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[Round?], any Error>) -> Void
    ) {
        guard let url = URL(string: urlSource.getCurrentSeasonRacesUrl()) else {
            resultQueue.async {
                completionHandler(.failure(NetworkError.urlError))
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completionHandler(.failure(NetworkError.fetchError(error!.localizedDescription)))
                return
            }

            do {
                let data = try Data(contentsOf: url)
                let races = try self.raceDecoder.decodeRaces(from: data)
                completionHandler(.success(races))
            } catch let error {
                completionHandler(.failure(NetworkError.fetchError(error.localizedDescription)))
            }
        }.resume()
    }
}
