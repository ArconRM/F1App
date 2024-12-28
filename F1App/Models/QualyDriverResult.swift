//
//  QualyDriverResult.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

struct QualyDriverResult {
    var position: Int

    var q1Time: String
    var q2Time: String?
    var q3Time: String?

    var driver: Driver
    var team: Team

    static var mock: Self {
        .init(
            position: 1,
            q1Time: "1:00.000",
            q2Time: "1:00.000",
            q3Time: "1:00.000",
            driver: Driver.mock,
            team: Team.mock
        )
    }
}
