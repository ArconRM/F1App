//
//  DriversChampionshipEntry.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 21.12.2024.
//

import Foundation

public struct DriversChampionshipEntry {
    public var points: Int
    public var position: Int
    public var driver: Driver
    public var team: Team

    public static var mock: Self {
        return .init(
            points: 100,
            position: 1,
            driver: Driver.mock,
            team: Team.mock
        )
    }

    public static var mockArray: [Self] {
        return stride(from: 0, to: 400, by: 50).map { DriversChampionshipEntry(points: $0, position: $0 / 50, driver: Driver.mock, team: Team.mock) }
    }
}
