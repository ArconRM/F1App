//
//  CircuitDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 28.12.2024.
//

import Foundation

protocol CircuitDecoder {
    
    func decodeCircuit(from data: Data) throws -> Circuit?

    func decodeCircuit(from json: [String: Any?]) throws -> Circuit?
    
}
