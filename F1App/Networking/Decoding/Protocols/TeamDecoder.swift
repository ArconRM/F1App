//
//  TeamDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 21.12.2024.
//

import Foundation

protocol TeamDecoder {

    func decodeTeam(from data: Data) throws -> Team?

    func decodeTeam(from json: [String: Any]) throws -> Team?

    func decodeTeams(from data: Data) throws -> [Team?]

    func decodeTeams(from json: [String: Any]) throws -> [Team?]
}
