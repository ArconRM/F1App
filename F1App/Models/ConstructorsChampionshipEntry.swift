//
//  ConstructorsChampionshipEntry.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 26.12.2024.
//

import Foundation

struct ConstructorsChampionshipEntry: Equatable {
    var points: Int
    var position: Int
    var team: Team

    static var mock: Self {
        .init(points: 666, position: 1, team: .mock)
    }

    static var mockArray: [Self] {
        return stride(from: 0, to: 400, by: 50).map { .init(points: $0, position: $0 / 50, team: Team.mock) }
    }
}
