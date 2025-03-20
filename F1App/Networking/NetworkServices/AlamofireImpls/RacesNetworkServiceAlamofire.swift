//
//  RacesNetworkServiceAlamofire.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.03.2025.
//

import Foundation
import Alamofire

struct RacesNetworkServiceAlamofire: RacesNetworkService {

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

        AF.request(nextSeasonRaceUrl).response { response in
            switch response.result {
            case .success(let data):
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

            case .failure(let error):
                resultQueue.async { completionHandler(.failure(NetworkError.fetchError(error.localizedDescription))) }
            }
        }
    }

    func fetchSeasonRaces(
        year: Int?,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<[Round?], any Error>) -> Void
    ) {
        let seasonRacesUrl = urlSource.getSeasonRacesUrl(year: year)

        AF.request(seasonRacesUrl).response { response in
            switch response.result {
            case .success(let data):
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

            case .failure(let error):
                resultQueue.async { completionHandler(.failure(NetworkError.fetchError(error.localizedDescription))) }
                return
            }
        }
    }
}
