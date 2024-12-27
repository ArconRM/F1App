//
//  ConstructorsChampionshipDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 26.12.2024.
//

import Foundation

struct ConstructorsChampionshipDecoderF1Connect: ConstructorsChampionshipDecoder {
    private let teamDecoder: TeamDecoder
    
    init(teamDecoder: TeamDecoder) {
        self.teamDecoder = teamDecoder
    }
    
    func decodeConstructorsChampionship(_ data: Data) throws -> [ConstructorsChampionshipEntry?] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return try decodeConstructorsChampionship(json)
        }
        return []
    }
    
    func decodeConstructorsChampionship(_ json: [String : Any]) throws -> [ConstructorsChampionshipEntry?] {
        if let championshipJsonArray = json["constructors_championship"] as? [[String: Any]] {

            var result: [ConstructorsChampionshipEntry] = []
            for json in championshipJsonArray {
                result.append(try decodeConstructorsChampionshipFromJson(json))
            }
            return result
        }

        return []
    }
    
    func decodeConstructorsChampionshipFromJson(_ json: [String: Any]) throws -> ConstructorsChampionshipEntry {
        guard let points = (json["points"] as? Int? ?? nil) as Int? else {
            throw SerializationError.missing("points")
        }

        guard let position = (json["position"] as? Int? ?? nil) as Int? else {
            throw SerializationError.missing("position")
        }

        guard let team = try teamDecoder.decodeTeam(from: json) else {
            throw SerializationError.invalid("team")
        }

        return ConstructorsChampionshipEntry(points: points, position: position, team: team)
    }
}