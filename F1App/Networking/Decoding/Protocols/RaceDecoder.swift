//
//  RaceDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation

protocol RaceDecoder {

    func decodeRace(from data: Data) throws -> ChampionshipRace?

    func decodeRace(from json: [String: Any]) throws -> ChampionshipRace?

    func decodeRaces(from data: Data) throws -> [ChampionshipRace?]

    func decodeRaces(from json: [String: Any]) throws -> [ChampionshipRace?]
}
