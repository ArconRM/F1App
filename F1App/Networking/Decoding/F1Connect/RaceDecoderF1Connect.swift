//
//  RaceDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation

// https://developer.apple.com/swift/blog/?id=37
struct RaceDecoderF1Connect: RaceDecoder {

    func decodeRace(from data: Data) throws -> Round? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return try decodeRace(from: json)
        }
        return nil
    }

    func decodeRace(from json: [String: Any]) throws -> Round? {
        guard let yearString = json["season"] as? String else {
            throw SerializationError.missing("season")
        }
        guard let year = Int(yearString) else {
            throw SerializationError.invalid("season")
        }
        
        if let racesJson = json["race"] as? [[String: Any]], racesJson.count == 1 {
            return try decodeRaceFromDict(dict: racesJson[0], year: year)
        }

        if let raceJson = json["race"] as? [String: Any] {
            return try decodeRaceFromDict(dict: raceJson, year: year)
        }

        return nil
    }

    func decodeRaces(from data: Data) throws -> [Round] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
           return try decodeRaces(from: json)
        }
        return []
    }

    func decodeRaces(from json: [String: Any]) throws -> [Round] {
        guard let yearString = json["season"] as? String else {
            throw SerializationError.missing("season")
        }
        guard let year = Int(yearString) else {
            throw SerializationError.invalid("season")
        }
        
        if let racesJsonArray = json["races"] as? [[String: Any]] {

            var races: [Round] = []
            for raceJson in racesJsonArray {
                races.append(try decodeRaceFromDict(dict: raceJson, year: year))
            }
            return races
        }
        return []
    }

    private func decodeRaceFromDict(dict: [String: Any?], year: Int) throws -> Round {
        // Not nested props
        let raceId = dict["raceId"] as? String

        guard let raceName = dict["raceName"] as? String else {
            throw SerializationError.missing("raceName")
        }

        let laps = dict["laps"] as? Int

        guard let round = dict["round"] as? Int else {
            throw SerializationError.missing("round")
        }

        let url = dict["url"] as? String

        // Schedule
        guard let scheduleDict = dict["schedule"] as? [String: Any] else {
            throw SerializationError.missing("schedule")
        }

        guard let raceScheduleDict = scheduleDict["race"] as? [String: String?] else {
            throw SerializationError.missing("raceSchedule")
        }
        let raceDate = raceScheduleDict["date"] ?? nil
        let raceTime = raceScheduleDict["time"] ?? nil

        guard let qualyScheduleDict = scheduleDict["qualy"] as? [String: String?] else {
            throw SerializationError.missing("qualySchedule")
        }
        let qualyDate = qualyScheduleDict["date"] ?? nil
        let qualyTime = qualyScheduleDict["time"] ?? nil

        guard let fp1ScheduleDict = scheduleDict["fp1"] as? [String: String?] else {
            throw SerializationError.missing("fp1Schedule")
        }
        let fp1Date = fp1ScheduleDict["date"] ?? nil
        let fp1Time = fp1ScheduleDict["time"] ?? nil

        guard let fp2ScheduleDict = scheduleDict["fp2"] as? [String: String?] else {
            throw SerializationError.missing("fp2Schedule")
        }
        let fp2Date = fp2ScheduleDict["date"] ?? nil
        let fp2Time = fp2ScheduleDict["time"] ?? nil

        guard let fp3ScheduleDict = scheduleDict["fp3"] as? [String: String?] else {
            throw SerializationError.missing("fp3Schedule")
        }
        let fp3Date = fp3ScheduleDict["date"] ?? nil
        let fp3Time = fp3ScheduleDict["time"] ?? nil

        guard let sprintQualyScheduleDict = scheduleDict["sprintQualy"] as? [String: String?] else {
            throw SerializationError.missing("sprintQualySchedule")
        }
        let sprintQualyDate = sprintQualyScheduleDict["date"] ?? nil
        let sprintQualyTime = sprintQualyScheduleDict["time"] ?? nil

        guard let sprintRaceScheduleDict = scheduleDict["sprintRace"] as? [String: String?] else {
            throw SerializationError.missing("sprintRaceSchedule")
        }
        let sprintRaceDate = sprintRaceScheduleDict["date"] ?? nil
        let sprintRaceTime = sprintRaceScheduleDict["time"] ?? nil

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
            
            winnerId = (winnerDict["driverId"] as? String)
            
            if let name = winnerDict["name"] as? String, let surname = winnerDict["surname"] as? String {
                winnerName = "\(name) \(surname)"
            }
        }

        // TeamWinner
        var teamWinnerId: String?
        var teamWinnerName: String?
        if let teamWinnerDict = dict["teamWinner"] as? [String: Any?] {
            teamWinnerId = teamWinnerDict["teamId"] as? String
            teamWinnerName = teamWinnerDict["teamName"] as? String
        }

        return Round(
            raceId: raceId,
            raceName: raceName,
            laps: laps,
            round: round,
            year: year,
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
