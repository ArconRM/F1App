//
//  DriversChampionshipDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 21.12.2024.
//

import Foundation

struct DriversChampionshipDecoderF1Connect: DriversChampionshipDecoder {
    private let driverDecoder: DriverDecoder
    private let teamDecoder: TeamDecoder

    init(driverDecoder: DriverDecoder, teamDecoder: TeamDecoder) {
        self.driverDecoder = driverDecoder
        self.teamDecoder = teamDecoder
    }

    func decodeDriversChampionship(_ data: Data) throws -> [DriversChampionshipEntry?] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return try decodeDriversChampionship(json)
        }
        return []
    }

    func decodeDriversChampionship(_ json: [String: Any]) throws -> [DriversChampionshipEntry?] {
        if let championshipJsonArray = json["drivers_championship"] as? [[String: Any]] {

            var result: [DriversChampionshipEntry] = []
            for json in championshipJsonArray {
                result.append(try decodeDriversChampionshipFromJson(json))
            }
            return result
        }

        return []
    }

    private func decodeDriversChampionshipFromJson(_ json: [String: Any]) throws -> DriversChampionshipEntry {

        guard let points = (json["points"] as? Int? ?? nil) as Int? else {
            throw SerializationError.missing("points")
        }

        guard let position = (json["position"] as? Int? ?? nil) as Int? else {
            throw SerializationError.missing("position")
        }

        guard let driver = try driverDecoder.decodeDriver(from: json) else {
            throw SerializationError.invalid("driver")
        }

        guard let team = try teamDecoder.decodeTeam(from: json) else {
            throw SerializationError.invalid("team")
        }

        return DriversChampionshipEntry(points: points, position: position, driver: driver, team: team)
    }
}
