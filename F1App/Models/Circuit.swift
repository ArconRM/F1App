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
    
    init(
        circuitId: String,
        name: String,
        country: String,
        city: String,
        length: Int,
        lapRecord: String,
        firstParticipationYear: Int,
        numberOfCorners: Int,
        fastestLapDriverId: String?,
        fastestLapTeamId: String?,
        fastestLapYear: Int?,
        url: String
    ) {
        self.circuitId = circuitId
        self.name = name
        self.country = country
        self.city = city
        self.length = length
        self.lapRecord = lapRecord
        self.firstParticipationYear = firstParticipationYear
        self.numberOfCorners = numberOfCorners
        self.fastestLapDriverId = fastestLapDriverId
        self.fastestLapTeamId = fastestLapTeamId
        self.fastestLapYear = fastestLapYear
        self.url = url
    }
}
