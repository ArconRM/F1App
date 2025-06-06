//
//  QualyDriverResult.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

struct QualyDriverResult: Equatable {
    var position: Int?

    var q1Time: String?
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

    static var mockArray: [Self] {
        var entries: [Self] = []

            for position in 1...10 {
                entries.append(
                    .init(
                        position: position,
                        q1Time: "1:00.000",
                        q2Time: "1:00.000",
                        q3Time: "1:00.000",
                        driver: Driver.mock,
                        team: Team.mock
                    )
                )
            }

            for position in 11...15 {
                entries.append(
                    .init(
                        position: position,
                        q1Time: "1:00.000",
                        q2Time: "1:00.000",
                        q3Time: nil,
                        driver: Driver.mock,
                        team: Team.mock
                    )
                )
            }

            for position in 16...20 {
                entries.append(
                    .init(
                        position: position,
                        q1Time: "1:00.000",
                        q2Time: nil,
                        q3Time: nil,
                        driver: Driver.mock,
                        team: Team.mock
                    )
                )
            }

            return entries

    }
}
