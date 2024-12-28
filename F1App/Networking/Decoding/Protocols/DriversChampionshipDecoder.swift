//
//  DriversChampionshipDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 21.12.2024.
//

import Foundation

protocol DriversChampionshipDecoder {

    func decodeDriversChampionship(from data: Data) throws -> [DriversChampionshipEntry]

    func decodeDriversChampionship(from json: [String: Any?]) throws -> [DriversChampionshipEntry]
}
