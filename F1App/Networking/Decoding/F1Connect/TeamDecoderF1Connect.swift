//
//  TeamDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 21.12.2024.
//

import Foundation

struct TeamDecoderF1Connect: TeamDecoder {

    func decodeTeam(from data: Data) throws -> Team? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return try decodeTeam(from: json)
        }
        return nil
    }

    func decodeTeam(from json: [String: Any]) throws -> Team? {
        if let teamsJson = json["team"] as? [[String: Any]], teamsJson.count == 1 {
            return try decodeTeamFromJson(teamsJson[0])
        }

        if let teamJson = json["team"] as? [String: Any] {
            return try decodeTeamFromJson(teamJson)
        }

        return nil
    }

    func decodeTeams(from data: Data) throws -> [Team?] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return try decodeTeams(from: json)
        }
        return []
    }

    func decodeTeams(from json: [String: Any]) throws -> [Team?] {
        if let teamsJsonArray = json["drivers"] as? [[String: Any]] {

            var teams: [Team?] = []
            for teamJson in teamsJsonArray {
                teams.append(try decodeTeamFromJson(teamJson))
            }
            return teams
        }
        return []
    }

    private func decodeTeamFromJson(_ json: [String: Any]) throws -> Team {

        guard let teamId = (json["teamId"] as? String? ?? nil) as String? else {
            throw SerializationError.missing("teamId")
        }

        guard let teamName = (json["teamName"] as? String? ?? nil) as String? else {
            throw SerializationError.missing("teamName")
        }

        guard let country = (json["country"] as? String? ?? nil) as String? else {
            throw SerializationError.missing("country")
        }

        let constructorsChampionships = (json["constructorsChampionships"] as? Int? ?? nil) as Int?

        let driversChampionships = (json["driversChampionships"] as? Int? ?? nil) as Int?

        return Team(
            teamId: teamId,
            teamName: teamName,
            country: country,
            constructorsChampionships: constructorsChampionships,
            driversChampionships: driversChampionships
        )
    }
}