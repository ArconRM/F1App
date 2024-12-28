//
//  ConstructorsChampionshipDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 26.12.2024.
//

import Foundation

protocol ConstructorsChampionshipDecoder {

    func decodeConstructorsChampionship(from data: Data) throws -> [ConstructorsChampionshipEntry]

    func decodeConstructorsChampionship(from json: [String: Any?]) throws -> [ConstructorsChampionshipEntry]
}
