//
//  RaceResultsDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

protocol RaceResultsDecoder {
    
    func decodeRaceResults(data: Data, isSprint: Bool) throws -> [RaceDriverResult]
    
    func decodeRaceResults(json: [String: Any], isSprint: Bool) throws -> [RaceDriverResult]
}
