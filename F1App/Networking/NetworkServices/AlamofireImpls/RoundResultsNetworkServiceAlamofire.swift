//
//  RoundResultsNetworkServiceAlamofire.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 20.03.2025.
//

import Foundation
import Alamofire

struct RoundResultsNetworkServiceAlamofire: RoundResultsNetworkService {
    private let urlSource: UrlSource

    private let practiceResultDecoder: PracticeResultsDecoder
    private let qualyResultDecoder: QualyResultsDecoder
    private let raceResultDecoder: RaceResultsDecoder

    init(
        urlSource: UrlSource,
        practiceResultDecoder: PracticeResultsDecoder,
        qualyResultDecoder: QualyResultsDecoder,
        raceResultDecoder: RaceResultsDecoder
    ) {
        self.urlSource = urlSource
        self.practiceResultDecoder = practiceResultDecoder
        self.qualyResultDecoder = qualyResultDecoder
        self.raceResultDecoder = raceResultDecoder
    }

    func fetchRoundResults(
        year: Int,
        roundNumber: Int,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<RoundResults, any Error>) -> Void
    ) {
        let dispatchGroup = DispatchGroup()
        var errors = [any Error]()

        var fp1Results = [PracticeDriverResult]()
        var fp2Results = [PracticeDriverResult]()
        var fp3Results = [PracticeDriverResult]()

        var sprintQualyResults = [QualyDriverResult]()
        var sprintRaceResults = [RaceDriverResult]()

        var qualyResults = [QualyDriverResult]()
        var raceResults = [RaceDriverResult]()

        DispatchQueue.global(qos: .background).async {
            dispatchGroup.enter()
            fetchPracticeResults(year: year, roundNumber: roundNumber, practiceNumber: 1) { result in
                defer { dispatchGroup.leave() }

                switch result {
                case .success(let results):
                    fp1Results = results
                case .failure(let error):
                    errors.append(error)
                }
            }

            Thread.sleep(forTimeInterval: 0.3)

            dispatchGroup.enter()
            fetchPracticeResults(year: year, roundNumber: roundNumber, practiceNumber: 2) { result in
                defer { dispatchGroup.leave() }

                switch result {
                case .success(let results):
                    fp2Results = results
                case .failure(let error):
                    errors.append(error)
                }
            }

            Thread.sleep(forTimeInterval: 0.3)

            dispatchGroup.enter()
            fetchPracticeResults(year: year, roundNumber: roundNumber, practiceNumber: 3) { result in
                defer { dispatchGroup.leave() }

                switch result {
                case .success(let results):
                    fp3Results = results
                case .failure(let error):
                    errors.append(error)
                }
            }

            Thread.sleep(forTimeInterval: 0.3)

            dispatchGroup.enter()
            fetchQualyResults(year: year, roundNumber: roundNumber, isSprint: true) { result in
                defer { dispatchGroup.leave() }

                switch result {
                case .success(let results):
                    sprintQualyResults = results
                case .failure(let error):
                    errors.append(error)
                }
            }

            Thread.sleep(forTimeInterval: 0.3)

            dispatchGroup.enter()
            fetchRaceResults(year: year, roundNumber: roundNumber, isSprint: true) { result in
                defer { dispatchGroup.leave() }

                switch result {
                case .success(let results):
                    sprintRaceResults = results
                case .failure(let error):
                    errors.append(error)
                }
            }

            Thread.sleep(forTimeInterval: 0.3)

            dispatchGroup.enter()
            fetchQualyResults(year: year, roundNumber: roundNumber, isSprint: false) { result in
                defer { dispatchGroup.leave() }

                switch result {
                case .success(let results):
                    qualyResults = results
                case .failure(let error):
                    errors.append(error)
                }
            }

            Thread.sleep(forTimeInterval: 0.3)

            dispatchGroup.enter()
            fetchRaceResults(year: year, roundNumber: roundNumber, isSprint: false) { result in
                defer { dispatchGroup.leave() }

                switch result {
                case .success(let results):
                    raceResults = results
                case .failure(let error):
                    errors.append(error)
                }
            }

            dispatchGroup.wait()

            if errors.isEmpty {
                let roundResults = RoundResults(
                    fp1Results: fp1Results,
                    fp2Results: fp2Results,
                    fp3Results: fp3Results,
                    sprintQualyResults: sprintQualyResults,
                    sprintRaceResults: sprintRaceResults,
                    qualyResults: qualyResults,
                    raceResults: raceResults
                )
                resultQueue.async { completionHandler(.success(roundResults)) }
            } else {
                resultQueue.async { completionHandler(.failure(NetworkError.multipleErrors(errors))) }
            }
        }
    }

    private func fetchPracticeResults(
        year: Int,
        roundNumber: Int,
        practiceNumber: Int,
        completionHandler: @escaping (Result<[PracticeDriverResult], any Error>) -> Void
    ) {
        let practiceResultsUrl = urlSource.getPracticeResultsUrl(year: year, practiceNumber: practiceNumber, roundNumber: roundNumber)

        AF.request(practiceResultsUrl).response { response in
            switch response.result {
            case .success(let data):
                guard data != nil else {
                    completionHandler(.success([]))
                    return
                }

                do {
                    let practiceResults = try practiceResultDecoder.decodePracticeResults(from: data!, practiceNumber: practiceNumber)
                    completionHandler(.success(practiceResults))
                } catch let error {
                   completionHandler(.failure(NetworkError.parserError(error.localizedDescription)))
                }

            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    private func fetchQualyResults(
        year: Int,
        roundNumber: Int,
        isSprint: Bool,
        completionHandler: @escaping (Result<[QualyDriverResult], any Error>) -> Void
    ) {
        let qualyResultsUrl = isSprint ?
        urlSource.getSprintQualyResultsUrl(year: year, roundNumber: roundNumber) :
        urlSource.getQualyResultsUrl(year: year, roundNumber: roundNumber)

        AF.request(qualyResultsUrl).response { response in
            switch response.result {
            case .success(let data):
                guard data != nil else {
                    completionHandler(.success([]))
                    return
                }

                do {
                    let qualyResults = try qualyResultDecoder.decodeQualyResults(from: data!, isSprint: isSprint)
                    completionHandler(.success(qualyResults))
                } catch let error {
                    completionHandler(.failure(NetworkError.parserError(error.localizedDescription)))
                }

            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    private func fetchRaceResults(
        year: Int,
        roundNumber: Int,
        isSprint: Bool,
        completionHandler: @escaping (Result<[RaceDriverResult], any Error>) -> Void
    ) {
        let raceResultsUrl = isSprint ?
        urlSource.getSprintRaceResultsUrl(year: year, roundNumber: roundNumber) :
        urlSource.getRaceResultsUrl(year: year, roundNumber: roundNumber)

        AF.request(raceResultsUrl).response { response in
            switch response.result {
            case .success(let data):
                guard data != nil else {
                    completionHandler(.success([]))
                    return
                }

                do {
                    let raceResults = try raceResultDecoder.decodeRaceResults(from: data!, isSprint: isSprint)
                    completionHandler(.success(raceResults))
                } catch let error {
                    completionHandler(.failure(NetworkError.parserError(error.localizedDescription)))
                }

            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
