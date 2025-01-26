//
//  RaceResultDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

struct RaceResultDecoderF1Connect: RaceResultsDecoder {
    private let driverDecoder: DriverDecoder
    private let teamDecoder: TeamDecoder

    init(driverDecoder: DriverDecoder, teamDecoder: TeamDecoder) {
        self.driverDecoder = driverDecoder
        self.teamDecoder = teamDecoder
    }

    func decodeRaceResults(from data: Data, isSprint: Bool) throws -> [RaceDriverResult] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
            return try decodeRaceResults(from: json, isSprint: isSprint)
        }
        return []
    }

    func decodeRaceResults(from json: [String: Any?], isSprint: Bool) throws -> [RaceDriverResult] {
        if let roundJson = json["races"] as? [String: Any?],
           let raceResultsJsonArray = roundJson[isSprint ? "sprintRaceResults" : "results"] as? [[String: Any?]] {

            var result: [RaceDriverResult] = []
            for json in raceResultsJsonArray {
                result.append(try decodeRaceDriverResultFromJson(json))
            }
            return result
        }

        return []
    }

    func decodeRaceDriverResultFromJson(_ json: [String: Any?]) throws -> RaceDriverResult {
        var position: String
        if let positionInt = json["position"] as? Int {
            position = "\(positionInt)"
        } else if let positionStr = json["position"] as? String {
            position = positionStr
        } else {
            throw SerializationError.missing(key: "position")
        }

        let grid = json["gridPosition"] as? Int ?? json["grid"] as? Int

        guard let points = json["points"] as? Int else {
            throw SerializationError.missing(key: "points")
        }

        let time = json["time"] as? String

        guard let driver = try driverDecoder.decodeDriver(from: json) else {
            throw SerializationError.invalid(key: "driver")
        }

        guard let team = try teamDecoder.decodeTeam(from: json) else {
            throw SerializationError.invalid(key: "team")
        }

        return RaceDriverResult(
            position: position,
            grid: grid,
            points: points,
            totalTime: time,
            driver: driver,
            team: team
        )
    }
}
