//
//  ConstructorsChampionshipDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 26.12.2024.
//

import Foundation

protocol ConstructorsChampionshipDecoder {
    
    func decodeConstructorsChampionship(_ data: Data) throws -> [ConstructorsChampionshipEntry?]

    func decodeConstructorsChampionship(_ json: [String: Any]) throws -> [ConstructorsChampionshipEntry?]
}
