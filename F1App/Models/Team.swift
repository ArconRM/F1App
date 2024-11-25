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
    public var constructorsChampionships: Int
    public var driversChampionships: Int
    
    init(
        teamId: String,
        teamName: String,
        country: String,
        constructorsChampionships: Int,
        driversChampionships: Int
    ) {
        self.teamId = teamId
        self.teamName = teamName
        self.country = country
        self.constructorsChampionships = constructorsChampionships
        self.driversChampionships = driversChampionships
    }
}
