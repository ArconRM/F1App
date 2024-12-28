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
            name: "Bahrein International Circuit",
            country: "Bahrein",
            city: "Sakhir",
            length: "100km",
            lapRecord: "1:31:447",
            firstParticipationYear: 2004,
            numberOfCorners: 69
        )
    }
}
