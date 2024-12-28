//
//  Circuit.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 20.11.2024.
//

import Foundation

struct Circuit: Codable {
    var circuitId: String
    var circuitName: String
    var country: String
    var city: String
    var circuitLength: Int
    var lapRecord: String
    var firstParticipationYear: Int
    var numberOfCorners: Int
    var fastestLapDriverId: String?
    var fastestLapTeamId: String?
    var fastestLapYear: Int?
    var url: String?
    
    static var mock: Self {
        .init(
            circuitId: "1",
            circuitName: "Circuit 1",
            country: "Country 1",
            city: "City 1",
            circuitLength: 100,
            lapRecord: "LapRecord 1",
            firstParticipationYear: 2021,
            numberOfCorners: 10
        )
    }
}
