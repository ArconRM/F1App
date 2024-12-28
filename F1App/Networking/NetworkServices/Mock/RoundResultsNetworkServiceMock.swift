//
//  RoundResultsNetworkServiceMock.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 28.12.2024.
//

import Foundation

struct RoundResultsNetworkServiceMock: RoundResultsNetworkService {
    private let driverDecoder: DriverDecoder
    private let teamDecoder: TeamDecoder
    
    private let practiceResultDecoder: PracticeResultsDecoder
    private let qualyResultDecoder: QualyResultsDecoder
    private let raceResultDecoder: RaceResultsDecoder
    
    init() {
        driverDecoder = DriverDecoderF1Connect()
        teamDecoder = TeamDecoderF1Connect()
        
        practiceResultDecoder = PracticeResultDecoderF1Connect(driverDecoder: driverDecoder, teamDecoder: teamDecoder)
        qualyResultDecoder = QualyResultDecoderF1Connect(driverDecoder: driverDecoder, teamDecoder: teamDecoder)
        raceResultDecoder = RaceResultDecoderF1Connect(driverDecoder: driverDecoder, teamDecoder: teamDecoder)
    }
    
    func fetchRoundResults(
        round: Round,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<RoundResults, any Error>) -> Void
    ) {
        do {
            let fp1Results = try fetchPracticeResults(practiceNumber: 1)
            let fp2Results = try fetchPracticeResults(practiceNumber: 2)
            let fp3Results = try fetchPracticeResults(practiceNumber: 3)
            
            let sprintQualyResults = try fetchQualyResults(isSprint: true)
            let sprintRaceResults = try fetchRaceResults(isSprint: true)
            
            let qualyResults = try fetchQualyResults(isSprint: false)
            let raceResults = try fetchRaceResults(isSprint: false)
            
            let roundResults = RoundResults(
                fp1Results: fp1Results,
                fp2Results: fp2Results,
                fp3Results: fp3Results,
                sprintQualyResults: sprintQualyResults,
                sprintRaceResults: sprintRaceResults,
                qualyResults: qualyResults,
                raceResults: raceResults
            )
            
        } catch let error {
            completionHandler(.failure(NetworkError.fetchError(error.localizedDescription)))
        }
    }
    
    private func fetchPracticeResults(practiceNumber: Int) throws -> [PracticeDriverResult] {
        if let path = Bundle.main.path(forResource: "fp\(practiceNumber)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let practiceResults = try practiceResultDecoder.decodePracticeResults(data: data, practiceNumber: practiceNumber)
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
                let qualyResults = try qualyResultDecoder.decodeQualyResults(data: data, isSprint: isSprint)
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
                let raceResults = try raceResultDecoder.decodeRaceResults(data: data, isSprint: isSprint)
                return raceResults
                
            } catch let error {
                throw error
            }
        }
        return []
    }
}
