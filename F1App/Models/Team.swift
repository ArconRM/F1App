//
//  Team.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 18.11.2024.
//

import Foundation

public struct Team: Codable {
    public var teamId: String
    public var teamName: String
    public var country: String
    public var constructorsChampionships: Int?
    public var driversChampionships: Int?

    public static var mock: Self {
        return .init(
            teamId: "1",
            teamName: "Team Name",
            country: "Country",
            constructorsChampionships: 5,
            driversChampionships: nil
        )
    }
}
