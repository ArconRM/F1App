//
//  Circuit.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 20.11.2024.
//

import Foundation

public struct Circuit: Codable {
    public var circuitId: String
    public var name: String
    public var country: String
    public var city: String
    public var length: Int
    public var lapRecord: String
    public var firstParticipationYear: Int
    public var numberOfCorners: Int
    public var fastestLapDriverId: String?
    public var fastestLapTeamId: String?
    public var fastestLapYear: Int?
    public var url: String
}
