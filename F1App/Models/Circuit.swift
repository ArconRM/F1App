//
//  Circuit.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 20.11.2024.
//

import Foundation

struct Circuit: Codable {
    var circuitId: String
    var name: String
    var country: String
    var city: String
    var length: Int
    var lapRecord: String
    var firstParticipationYear: Int
    var numberOfCorners: Int
    var fastestLapDriverId: String?
    var fastestLapTeamId: String?
    var fastestLapYear: Int?
    var url: String
}
