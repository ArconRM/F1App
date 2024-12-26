//
//  DriversChampionshipDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 21.12.2024.
//

import Foundation

protocol DriversChampionshipDecoder {

    func decodeDriversChampionship(_ data: Data) throws -> [DriversChampionshipEntry?]

    func decodeDriversChampionship(_ json: [String: Any]) throws -> [DriversChampionshipEntry?]
}
