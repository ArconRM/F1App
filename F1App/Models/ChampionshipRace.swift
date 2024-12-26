//
//  ChampionshipRace.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 20.11.2024.
//

import Foundation

public struct ChampionshipRace {
    public var raceId: String?
    public var raceName: String
    public var laps: Int?
    public var round: Int
    public var url: String?

    public var circuitId: String
    public var circuitName: String

    public var winnerId: String?
    public var winnerName: String?

    public var teamWinnerId: String?
    public var teamWinnerName: String?

    // Schedule
    public var fp1Datetime: Date?
    public var fp2Datetime: Date?
    public var fp3Datetime: Date?
    public var sprintQualyDatetime: Date?
    public var sprintRaceDatetime: Date?
    public var qualyDatetime: Date?
    public var raceDatetime: Date?

    public static var mock: Self {
        let fp1Datetime = "2024-02-29 11:30:00 +0000"
        let fp2Datetime = "2024-02-29 15:00:00 +0000"
        let fp3Datetime = "2024-03-01 12:30:00 +0000"
        let sprintQualyDatetime = "2024-03-01 12:30:00 +0000"
        let sprintRaceDatetime = "2024-03-01 16:30:00 +0000"
        let qualyDatetime = "2024-03-01 16:00:00 +0000"
        let raceDatetime = "2024-03-02 15:00:00 +0000"

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

//        return ChampionshipRace(
//            raceId: "bahrein_2024",
//            raceName: "Gulf Air Bahrain Grand Prix 2024",
//            laps: 57,
//            round: 1,
//            url: "https://en.wikipedia.org/wiki/2024_Bahrain_Grand_Prix",
//            circuitId: "bahrein",
//            circuitName: "Bahrein International Circuit",
//            winnerId: "max_verstappen",
//            winnerName: "Max",
//            teamWinnerId: "red_bull",
//            teamWinnerName: "Red Bull Racing",
//            fp1Datetime: dateFormatter.date(from: fp1Datetime),
//            fp2Datetime: dateFormatter.date(from: fp2Datetime),
//            fp3Datetime: nil,
//            sprintQualyDatetime: dateFormatter.date(from: sprintQualyDatetime),
//            sprintRaceDatetime: dateFormatter.date(from: sprintRaceDatetime),
//            raceDatetime: dateFormatter.date(from: raceDatetime),
//            qualyDatetime: dateFormatter.date(from: qualyDatetime)
//        )

        return .init(
            raceId: "bahrein_2024",
            raceName: "Gulf Air Bahrain Grand Prix 2024",
            laps: 57,
            round: 1,
            url: "https://en.wikipedia.org/wiki/2024_Bahrain_Grand_Prix",
            circuitId: "bahrein",
            circuitName: "Bahrein International Circuit",
            winnerId: "max_verstappen",
            winnerName: "Max Verstappen",
            teamWinnerId: "red_bull",
            teamWinnerName: "Red Bull Racing",
            fp1Datetime: dateFormatter.date(from: fp1Datetime),
            fp2Datetime: dateFormatter.date(from: fp2Datetime),
            fp3Datetime: dateFormatter.date(from: fp3Datetime),
            sprintQualyDatetime: nil,
            sprintRaceDatetime: nil,
            qualyDatetime: dateFormatter.date(from: qualyDatetime),
            raceDatetime: dateFormatter.date(from: raceDatetime)
        )
    }
}
