//
//  QualyResultDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

struct QualyResultDecoderF1Connect: QualyResultsDecoder {
    private let driverDecoder: DriverDecoder
    private let teamDecoder: TeamDecoder

    init(driverDecoder: DriverDecoder, teamDecoder: TeamDecoder) {
        self.driverDecoder = driverDecoder
        self.teamDecoder = teamDecoder
    }

    func decodeQualyResults(from data: Data, isSprint: Bool) throws -> [QualyDriverResult] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
            return try decodeQualyResults(from: json, isSprint: isSprint)
        }
        return []
    }

    func decodeQualyResults(from json: [String: Any?], isSprint: Bool) throws -> [QualyDriverResult] {
        if let roundJson = json["races"] as? [String: Any?],
           let qualyResultsJsonArray = roundJson[isSprint ? "sprintQualyResults" : "qualyResults"] as? [[String: Any?]] {

            var result: [QualyDriverResult] = []
            for json in qualyResultsJsonArray {
                result.append(try decodeQualyDriverResultFromJson(json, isSprint: isSprint))
            }
            return result
        }

        return []
    }

    private func decodeQualyDriverResultFromJson(_ json: [String: Any?], isSprint: Bool) throws -> QualyDriverResult {
        let position = json["gridPosition"] as? Int

        let q1Time = (json[isSprint ? "sq1" : "q1"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)

        let q2Time = (json[isSprint ? "sq2" : "q2"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)

        let q3Time = (json[isSprint ? "Sq3" : "q3"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let driver = try driverDecoder.decodeDriver(from: json) else {
            throw SerializationError.invalid(key: "driver")
        }

        guard let team = try teamDecoder.decodeTeam(from: json) else {
            throw SerializationError.invalid(key: "team")
        }

        return QualyDriverResult(
            position: position,
            q1Time: q1Time,
            q2Time: q2Time,
            q3Time: q3Time,
            driver: driver,
            team: team
        )
    }
}
