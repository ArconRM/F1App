//
//  RaceDriverResult.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

struct RaceDriverResult {
    var position: Int
    var grid: Int
    var points: Int

    var totalTime: String

    var driver: Driver
    var team: Team

    static var mock: Self {
        .init(
            position: 1,
            grid: 20,
            points: 69,
            totalTime: "00:00:00.000",
            driver: Driver.mock,
            team: Team.mock
        )
    }
}
