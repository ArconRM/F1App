//
//  PracticeResultDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

struct PracticeResultDecoderF1Connect: PracticeResultsDecoder {
    private let driverDecoder: DriverDecoder
    private let teamDecoder: TeamDecoder
    
    init(driverDecoder: DriverDecoder, teamDecoder: TeamDecoder) {
        self.driverDecoder = driverDecoder
        self.teamDecoder = teamDecoder
    }
    
    func decodePracticeResults(data: Data, practiceNumber: Int) throws -> [PracticeDriverResult] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return try decodePracticeResults(json: json, practiceNumber: practiceNumber)
        }
        return []
    }
    
    func decodePracticeResults(json: [String : Any], practiceNumber: Int) throws -> [PracticeDriverResult] {
        if let roundJson = json["races"] as? [String: Any],
           let practiceResultsJsonArray = roundJson["FP\(practiceNumber)_Results"] as? [[String: Any]] {

            var result: [PracticeDriverResult] = []
            for (position, json) in practiceResultsJsonArray.enumerated() {
                result.append(try decodePracticeDriverResultFromJson(json: json, position: position + 1))
            }
            return result
        }

        return []
    }
    
    private func decodePracticeDriverResultFromJson(json: [String: Any], position: Int) throws -> PracticeDriverResult {
        guard let time = json["time"] as? String else {
            throw SerializationError.missing("time")
        }
        
        guard let driver = try driverDecoder.decodeDriver(from: json) else {
            throw SerializationError.invalid("driver")
        }
        
        guard let team = try teamDecoder.decodeTeam(from: json) else {
            throw SerializationError.invalid("team")
        }
        
        return PracticeDriverResult(
            position: position,
            time: time,
            driver: driver,
            team: team
        )
    }
}
