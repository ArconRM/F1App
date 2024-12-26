//
//  F1ConnectTeamDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 21.12.2024.
//

import Foundation

struct F1ConnectTeamDecoder: TeamDecoder {

    func decodeTeam(from data: Data) throws -> Team? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let teamJson = json["team"] as? [[String: Any]], teamJson.count == 1 {

            if let team = try decodeTeamFromJson(teamJson[0]) {
                return team
            }
        }
        return nil
    }

    func decodeTeams(from data: Data) throws -> [Team?] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let teamsJsonArray = json["drivers"] as? [[String: Any]] {

            var teams: [Team?] = []
            for teamJson in teamsJsonArray {
                let team = try decodeTeamFromJson(teamJson)
                teams.append(team)
            }
            return teams
        }
        return []
    }

    private func decodeTeamFromJson(_ json: [String: Any]) throws -> Team? {
        guard let teamId = (json["teamId"] as? String? ?? nil) as String? else {
            throw SerializationError.missing("teamId")
        }

        guard let teamName = (json["teamName"] as? String? ?? nil) as String? else {
            throw SerializationError.missing("teamName")
        }

        guard let country = (json["country"] as? String? ?? nil) as String? else {
            throw SerializationError.missing("country")
        }

        guard let constructorsChampionships = (json["constructorsChampionships"] as? Int? ?? nil) as Int? else {
            throw SerializationError.missing("constructorsChampionships")
        }

        guard let driversChampionships = (json["driversChampionships"] as? Int? ?? nil) as Int? else {
            throw SerializationError.missing("driversChampionships")
        }

        return Team(
            teamId: teamId,
            teamName: teamName,
            country: country,
            constructorsChampionships: constructorsChampionships,
            driversChampionships: driversChampionships
        )
    }
}
