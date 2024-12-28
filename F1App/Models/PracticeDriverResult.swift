//
//  PracticeDriverResult.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

struct PracticeDriverResult {
    var position: Int
    
    var time: String
    
    var driver: Driver
    var team: Team
    
    static var mock: Self {
        .init(
            position: 1,
            time: "00:00:00.000",
            driver: Driver.mock,
            team: Team.mock
        )
    }
}
