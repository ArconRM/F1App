//
//  RoundResults.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

struct RoundResults {
    var fp1Results: [PracticeDriverResult]
    var fp2Results: [PracticeDriverResult]
    var fp3Results: [PracticeDriverResult]

    var sprintQualyResults: [QualyDriverResult]
    var sprintRaceResults: [RaceDriverResult]

    var qualyResults: [QualyDriverResult]
    var raceResults: [RaceDriverResult]

    static var mock: Self {
        .init(
            fp1Results: [PracticeDriverResult.mock],
            fp2Results: [PracticeDriverResult.mock],
            fp3Results: [],
            sprintQualyResults: [QualyDriverResult.mock],
            sprintRaceResults: [RaceDriverResult.mock],
            qualyResults: [QualyDriverResult.mock],
            raceResults: [RaceDriverResult.mock]
        )
    }
}
