//
//  RaceDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation

protocol RaceDecoder {

    func decodeRace(from data: Data) throws -> Round?

    func decodeRace(from json: [String: Any]) throws -> Round?

    func decodeRaces(from data: Data) throws -> [Round]

    func decodeRaces(from json: [String: Any]) throws -> [Round]
}
