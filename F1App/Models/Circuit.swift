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
    var length: String
    var lapRecord: String
    var firstParticipationYear: Int
    var numberOfCorners: Int?
    var url: String?

    static var mock: Self {
        .init(
            circuitId: "1",
            name: "Circuit 1",
            country: "Country 1",
            city: "City 1",
            length: "100km",
            lapRecord: "LapRecord 1",
            firstParticipationYear: 2021
        )
    }
}
