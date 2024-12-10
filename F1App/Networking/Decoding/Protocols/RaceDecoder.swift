//
//  RaceDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation

public protocol RaceDecoder {

    func decodeRace(from data: Data) throws -> ChampionshipRace?

    func decodeRaces(from data: Data) throws -> [ChampionshipRace?]
}
