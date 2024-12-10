//
//  RaceDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation

public struct RaceDecoderF1Connect: RaceDecoder {
    public func decodeRace(from data: Data) throws -> ChampionshipRace? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let raceJson = json["race"] as? [[String: Any]], raceJson.count == 1 {

            if let race = try ChampionshipRace(json: raceJson[0]) {
                return race
            }
        }
        return nil
    }

    public func decodeRaces(from data: Data) throws -> [ChampionshipRace?] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let racesJsonArray = json["races"] as? [[String: Any]] {

            var races: [ChampionshipRace] = []
            for raceJson in racesJsonArray {
                if let race = try ChampionshipRace(json: raceJson) {
                    races.append(race)
                }
            }
            return races
        }
        return []
    }
}
