//
//  DriversChampionshipEntry.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 21.12.2024.
//

import Foundation

struct DriversChampionshipEntry: Equatable {
    var points: Double
    var position: Int?
    var driver: Driver
    var team: Team

    static var mock: Self {
        return .init(
            points: 100,
            position: 1,
            driver: Driver.mock,
            team: Team.mock
        )
    }

    static var mockArray: [Self] {
        return stride(from: 0, to: 400, by: 50).map { .init(points: Double($0), position: $0 / 50, driver: Driver.mock, team: Team.mock) }
    }
}
