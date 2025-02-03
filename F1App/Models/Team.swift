//
//  Team.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 18.11.2024.
//

import Foundation

struct Team: Equatable {
    var teamId: String?
    var teamName: String
    var country: String
    var constructorsChampionships: Int?
    var driversChampionships: Int?

    static var mock: Self {
        return .init(
            teamId: "1",
            teamName: "Team Name",
            country: "Country",
            constructorsChampionships: 5,
            driversChampionships: nil
        )
    }
}
