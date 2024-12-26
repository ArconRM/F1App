//
//  RaceDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation

// https://developer.apple.com/swift/blog/?id=37
struct RaceDecoderF1Connect: RaceDecoder {

    func decodeRace(from data: Data) throws -> ChampionshipRace? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return try decodeRace(from: json)
        }
        return nil
    }

    func decodeRace(from json: [String: Any]) throws -> ChampionshipRace? {
        if let racesJson = json["race"] as? [[String: Any]], racesJson.count == 1 {
            return try decodeRaceFromDict(racesJson[0])
        }

        if let raceJson = json["race"] as? [String: Any] {
            return try decodeRaceFromDict(raceJson)
        }

        return nil
    }

    func decodeRaces(from data: Data) throws -> [ChampionshipRace?] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
           return try decodeRaces(from: json)
        }
        return []
    }

    func decodeRaces(from json: [String: Any]) throws -> [ChampionshipRace?] {
        if let racesJsonArray = json["races"] as? [[String: Any]] {

            var races: [ChampionshipRace?] = []
            for raceJson in racesJsonArray {
                races.append(try decodeRaceFromDict(raceJson))
            }
            return races
        }
        return []
    }

    private func decodeRaceFromDict(_ dict: [String: Any?]) throws -> ChampionshipRace {
        // Not nested props
        let raceId = (dict["raceId"] as? String? ?? nil) as String?

        guard let raceName = dict["raceName"] as? String else {
            throw SerializationError.missing("raceName")
        }

        let laps = (dict["laps"] as? Int? ?? nil) as Int?

        guard let round = dict["round"] as? Int else {
            throw SerializationError.missing("round")
        }

        let url = (dict["url"] as? String? ?? nil) as String?

        // Schedule
        guard let scheduleDict = dict["schedule"] as? [String: Any] else {
            throw SerializationError.missing("schedule")
        }

        guard let raceScheduleDict = scheduleDict["race"] as? [String: String?] else {
            throw SerializationError.missing("raceSchedule")
        }
        let raceDate = (raceScheduleDict["date"] ?? nil) as String?
        let raceTime = (raceScheduleDict["time"] ?? nil) as String?

        guard let qualyScheduleDict = scheduleDict["qualy"] as? [String: String?] else {
            throw SerializationError.missing("qualySchedule")
        }
        let qualyDate = (qualyScheduleDict["date"] ?? nil) as String?
        let qualyTime = (qualyScheduleDict["time"] ?? nil) as String?

        guard let fp1ScheduleDict = scheduleDict["fp1"] as? [String: String?] else {
            throw SerializationError.missing("fp1Schedule")
        }
        let fp1Date = (fp1ScheduleDict["date"] ?? nil) as String?
        let fp1Time = (fp1ScheduleDict["time"] ?? nil) as String?

        guard let fp2ScheduleDict = scheduleDict["fp2"] as? [String: String?] else {
            throw SerializationError.missing("fp2Schedule")
        }
        let fp2Date = (fp2ScheduleDict["date"] ?? nil) as String?
        let fp2Time = (fp2ScheduleDict["time"] ?? nil) as String?

        guard let fp3ScheduleDict = scheduleDict["fp3"] as? [String: String?] else {
            throw SerializationError.missing("fp3Schedule")
        }
        let fp3Date = (fp3ScheduleDict["date"] ?? nil) as String?
        let fp3Time = (fp3ScheduleDict["time"] ?? nil) as String?

        guard let sprintQualyScheduleDict = scheduleDict["sprintQualy"] as? [String: String?] else {
            throw SerializationError.missing("sprintQualySchedule")
        }
        let sprintQualyDate = (sprintQualyScheduleDict["date"] ?? nil) as String?
        let sprintQualyTime = (sprintQualyScheduleDict["time"] ?? nil) as String?

        guard let sprintRaceScheduleDict = scheduleDict["sprintRace"] as? [String: String?] else {
            throw SerializationError.missing("sprintRaceSchedule")
        }
        let sprintRaceDate = (sprintRaceScheduleDict["date"] ?? nil) as String?
        let sprintRaceTime = (sprintRaceScheduleDict["time"] ?? nil) as String?

        // Circuit
        guard let circuitDict = dict["circuit"] as? [String: Any?],
              let circuitId = circuitDict["circuitId"] as? String,
              let circuitName = circuitDict["circuitName"] as? String
        else {
            throw SerializationError.missing("circuit")
        }

        // Winner
        var winnerId: String?
        var winnerName: String?
        if let winnerDict = dict["winner"] as? [String: Any?] {
            winnerId = (winnerDict["driverId"] as? String? ?? nil) as String?
            if let name = winnerDict["name"] as? String, let surname = winnerDict["surname"] as? String {
                winnerName = "\(name) \(surname)"
            }
        }

        // TeamWinner
        var teamWinnerId: String?
        var teamWinnerName: String?
        if let teamWinnerDict = dict["teamWinner"] as? [String: Any?] {
            teamWinnerId = (teamWinnerDict["teamId"] as? String? ?? nil)
            teamWinnerName = (teamWinnerDict["teamName"] as? String? ?? nil)
        }

        return ChampionshipRace(
            raceId: raceId,
            raceName: raceName,
            laps: laps,
            round: round,
            url: url,
            circuitId: circuitId,
            circuitName: circuitName,
            winnerId: winnerId,
            winnerName: winnerName,
            teamWinnerId: teamWinnerId,
            teamWinnerName: teamWinnerName,
            fp1Datetime: getDateTime(date: fp1Date, time: fp1Time),
            fp2Datetime: getDateTime(date: fp2Date, time: fp2Time),
            fp3Datetime: getDateTime(date: fp3Date, time: fp3Time),
            sprintQualyDatetime: getDateTime(date: sprintQualyDate, time: sprintQualyTime),
            sprintRaceDatetime: getDateTime(date: sprintRaceDate, time: sprintRaceTime),
            qualyDatetime: getDateTime(date: qualyDate, time: qualyTime),
            raceDatetime: getDateTime(date: raceDate, time: raceTime)
        )
    }

    private func getDateTime(date: String?, time: String?) -> Date? {
        guard let date = date, let time = time else {
            return nil
        }

        let dateTimeString = "\(date)T\(time)"
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: dateTimeString)
    }
}
