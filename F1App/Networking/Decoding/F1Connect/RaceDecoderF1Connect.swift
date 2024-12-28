//
//  RaceDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation

// https://developer.apple.com/swift/blog/?id=37
struct RaceDecoderF1Connect: RaceDecoder {
    private let circuitDecoder: CircuitDecoder
    private let driverDecoder: DriverDecoder
    private let teamDecoder: TeamDecoder

    init(circuitDecoder: CircuitDecoder, driverDecoder: DriverDecoder, teamDecoder: TeamDecoder) {
        self.circuitDecoder = circuitDecoder
        self.driverDecoder = driverDecoder
        self.teamDecoder = teamDecoder
    }

    func decodeRace(from data: Data) throws -> Round? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
            return try decodeRace(from: json)
        }
        return nil
    }

    func decodeRace(from json: [String: Any?]) throws -> Round? {
        guard let yearString = json["season"] as? String else {
            throw SerializationError.missing(key: "season")
        }
        guard let year = Int(yearString) else {
            throw SerializationError.invalid(key: "season")
        }

        if let racesJson = json["race"] as? [[String: Any?]], racesJson.count == 1 {
            return try decodeRaceFromJson(racesJson[0], year: year)
        }

        if let raceJson = json["race"] as? [String: Any?] {
            return try decodeRaceFromJson(raceJson, year: year)
        }

        return try decodeRaceFromJson(json, year: year)
    }

    func decodeRaces(from data: Data) throws -> [Round] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
           return try decodeRaces(from: json)
        }
        return []
    }

    func decodeRaces(from json: [String: Any?]) throws -> [Round] {
        guard let yearString = json["season"] as? String else {
            throw SerializationError.missing(key: "season")
        }
        guard let year = Int(yearString) else {
            throw SerializationError.invalid(key: "season")
        }

        if let racesJsonArray = json["races"] as? [[String: Any?]] {

            var races: [Round] = []
            for raceJson in racesJsonArray {
                races.append(try decodeRaceFromJson(raceJson, year: year))
            }
            return races
        }
        return []
    }

    private func decodeRaceFromJson(_ json: [String: Any?], year: Int) throws -> Round {
        // Not nested props
        let raceId = json["raceId"] as? String

        guard let raceName = json["raceName"] as? String else {
            throw SerializationError.missing(key: "raceName")
        }

        let laps = json["laps"] as? Int

        guard let round = json["round"] as? Int else {
            throw SerializationError.missing(key: "round")
        }

        let url = json["url"] as? String

        // Schedule
        guard let scheduleDict = json["schedule"] as? [String: Any?] else {
            throw SerializationError.missing(key: "schedule")
        }

        guard let raceScheduleDict = scheduleDict["race"] as? [String: String?] else {
            throw SerializationError.missing(key: "raceSchedule")
        }
        let raceDate = raceScheduleDict["date"] ?? nil
        let raceTime = raceScheduleDict["time"] ?? nil

        guard let qualyScheduleDict = scheduleDict["qualy"] as? [String: String?] else {
            throw SerializationError.missing(key: "qualySchedule")
        }
        let qualyDate = qualyScheduleDict["date"] ?? nil
        let qualyTime = qualyScheduleDict["time"] ?? nil

        guard let fp1ScheduleDict = scheduleDict["fp1"] as? [String: String?] else {
            throw SerializationError.missing(key: "fp1Schedule")
        }
        let fp1Date = fp1ScheduleDict["date"] ?? nil
        let fp1Time = fp1ScheduleDict["time"] ?? nil

        guard let fp2ScheduleDict = scheduleDict["fp2"] as? [String: String?] else {
            throw SerializationError.missing(key: "fp2Schedule")
        }
        let fp2Date = fp2ScheduleDict["date"] ?? nil
        let fp2Time = fp2ScheduleDict["time"] ?? nil

        guard let fp3ScheduleDict = scheduleDict["fp3"] as? [String: String?] else {
            throw SerializationError.missing(key: "fp3Schedule")
        }
        let fp3Date = fp3ScheduleDict["date"] ?? nil
        let fp3Time = fp3ScheduleDict["time"] ?? nil

        guard let sprintQualyScheduleDict = scheduleDict["sprintQualy"] as? [String: String?] else {
            throw SerializationError.missing(key: "sprintQualySchedule")
        }
        let sprintQualyDate = sprintQualyScheduleDict["date"] ?? nil
        let sprintQualyTime = sprintQualyScheduleDict["time"] ?? nil

        guard let sprintRaceScheduleDict = scheduleDict["sprintRace"] as? [String: String?] else {
            throw SerializationError.missing(key: "sprintRaceSchedule")
        }
        let sprintRaceDate = sprintRaceScheduleDict["date"] ?? nil
        let sprintRaceTime = sprintRaceScheduleDict["time"] ?? nil

        let circuit: Circuit?
        if let circuitJson = json["circuit"] as? [String: Any?] {
            circuit = try circuitDecoder.decodeCircuit(from: circuitJson)
        } else {
            throw SerializationError.missing(key: "circuit")
        }

        var winner: Driver?
        if let winnerJson = json["winner"] as? [String: Any?] {
            winner = try driverDecoder.decodeDriver(from: winnerJson)
        }

        var teamWinner: Team?
        if let teamWinnerJson = json["teamWinner"] as? [String: Any?] {
            teamWinner = try teamDecoder.decodeTeam(from: teamWinnerJson)
        }

        return Round(
            raceId: raceId,
            raceName: raceName,
            laps: laps,
            round: round,
            year: year,
            url: url,
            circuit: circuit,
            winner: winner,
            teamWinner: teamWinner,
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
