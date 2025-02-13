//
//  RoundResultsNetworkServiceMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 28.12.2024.
//

import Foundation

struct RoundResultsNetworkServiceMock: RoundResultsNetworkService {
    private let practiceResultDecoder: PracticeResultsDecoder
    private let qualyResultDecoder: QualyResultsDecoder
    private let raceResultDecoder: RaceResultsDecoder

    init() {
        let driverDecoder = DriverDecoderF1Connect()
        let teamDecoder = TeamDecoderF1Connect()

        practiceResultDecoder = PracticeResultDecoderF1Connect(driverDecoder: driverDecoder, teamDecoder: teamDecoder)
        qualyResultDecoder = QualyResultDecoderF1Connect(driverDecoder: driverDecoder, teamDecoder: teamDecoder)
        raceResultDecoder = RaceResultDecoderF1Connect(driverDecoder: driverDecoder, teamDecoder: teamDecoder)
    }

    func fetchRoundResults(
        year: Int,
        roundNumber round: Int,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<RoundResults, any Error>) -> Void
    ) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fp1Results = try fetchPracticeResults(practiceNumber: 1)
                let fp2Results = try fetchPracticeResults(practiceNumber: 2)
                let fp3Results = try fetchPracticeResults(practiceNumber: 3)

                let sprintQualyResults = try fetchQualyResults(isSprint: true)
                let sprintRaceResults = try fetchRaceResults(isSprint: true)

                let qualyResults = try fetchQualyResults(isSprint: false)
                let raceResults = try fetchRaceResults(isSprint: false)

                Thread.sleep(forTimeInterval: 2)

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

            } catch let error {
                resultQueue.async { completionHandler(.failure(error)) }
            }
        }
    }

    private func fetchPracticeResults(practiceNumber: Int) throws -> [PracticeDriverResult] {
        if let path = Bundle.main.path(forResource: "fp\(practiceNumber)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let practiceResults = try practiceResultDecoder.decodePracticeResults(from: data, practiceNumber: practiceNumber)
                return practiceResults

            } catch let error {
                throw error
            }
        }
        return []
    }

    private func fetchQualyResults(isSprint: Bool) throws -> [QualyDriverResult] {
        if let path = Bundle.main.path(forResource: isSprint ? "sprint-qualy" : "qualy", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let qualyResults = try qualyResultDecoder.decodeQualyResults(from: data, isSprint: isSprint)
                return qualyResults

            } catch let error {
                throw error
            }
        }
        return []
    }

    private func fetchRaceResults(isSprint: Bool) throws -> [RaceDriverResult] {
        if let path = Bundle.main.path(forResource: isSprint ? "sprint-race" : "race", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let raceResults = try raceResultDecoder.decodeRaceResults(from: data, isSprint: isSprint)
                return raceResults

            } catch let error {
                throw error
            }
        }
        return []
    }
}
