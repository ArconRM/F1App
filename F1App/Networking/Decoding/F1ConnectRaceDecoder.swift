//
//  F1ConnectRaceDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation

public struct F1ConnectRaceDecoder: RaceDecoder {
    public func decodeRace(from data: Data) throws -> ChampionshipRace? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let raceJson = json["race"] as? [[String: Any]], raceJson.count == 1 {

            if let race = try decodeRaceFromJson(raceJson[0]) {
                return race
            }
        }
        return nil
    }

    public func decodeRaces(from data: Data) throws -> [ChampionshipRace?] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let racesJsonArray = json["races"] as? [[String: Any]] {

            var races: [ChampionshipRace] = []
            for raceJson in racesJsonArray {
                if let race = try decodeRaceFromJson(raceJson) {
                    races.append(race)
                }
            }
            return races
        }
        return []
    }
    
    private func decodeRaceFromJson(_ json: [String: Any?]) throws -> ChampionshipRace? {
        // Not nested props
        let raceId = (json["raceId"] as? String? ?? nil) as String?

        guard let raceName = json["raceName"] as? String else {
            throw SerializationError.missing("raceName")
        }

        let laps = (json["laps"] as? Int? ?? nil) as Int?

        guard let round = json["round"] as? Int else {
            throw SerializationError.missing("round")
        }

        let url = (json["url"] as? String? ?? nil) as String?

        // Schedule
        guard let scheduleJson = json["schedule"] as? [String: Any] else {
            throw SerializationError.missing("schedule")
        }

        guard let raceScheduleJson = scheduleJson["race"] as? [String: String?] else {
            throw SerializationError.missing("raceSchedule")
        }
        let raceDate = (raceScheduleJson["date"] ?? nil) as String?
        let raceTime = (raceScheduleJson["time"] ?? nil) as String?

        guard let qualyScheduleJson = scheduleJson["qualy"] as? [String: String?] else {
            throw SerializationError.missing("qualySchedule")
        }
        let qualyDate = (qualyScheduleJson["date"] ?? nil) as String?
        let qualyTime = (qualyScheduleJson["time"] ?? nil) as String?

        guard let fp1ScheduleJson = scheduleJson["fp1"] as? [String: String?] else {
            throw SerializationError.missing("fp1Schedule")
        }
        let fp1Date = (fp1ScheduleJson["date"] ?? nil) as String?
        let fp1Time = (fp1ScheduleJson["time"] ?? nil) as String?

        guard let fp2ScheduleJson = scheduleJson["fp2"] as? [String: String?] else {
            throw SerializationError.missing("fp2Schedule")
        }
        let fp2Date = (fp2ScheduleJson["date"] ?? nil) as String?
        let fp2Time = (fp2ScheduleJson["time"] ?? nil) as String?

        guard let fp3ScheduleJson = scheduleJson["fp3"] as? [String: String?] else {
            throw SerializationError.missing("fp3Schedule")
        }
        let fp3Date = (fp3ScheduleJson["date"] ?? nil) as String?
        let fp3Time = (fp3ScheduleJson["time"] ?? nil) as String?

        guard let sprintQualyScheduleJson = scheduleJson["sprintQualy"] as? [String: String?] else {
            throw SerializationError.missing("sprintQualySchedule")
        }
        let sprintQualyDate = (sprintQualyScheduleJson["date"] ?? nil) as String?
        let sprintQualyTime = (sprintQualyScheduleJson["time"] ?? nil) as String?

        guard let sprintRaceScheduleJson = scheduleJson["sprintRace"] as? [String: String?] else {
            throw SerializationError.missing("sprintRaceSchedule")
        }
        let sprintRaceDate = (sprintRaceScheduleJson["date"] ?? nil) as String?
        let sprintRaceTime = (sprintRaceScheduleJson["time"] ?? nil) as String?

        // Circuit
        guard let circuitJson = json["circuit"] as? [String: Any?],
              let circuitId = circuitJson["circuitId"] as? String,
              let circuitName = circuitJson["circuitName"] as? String
        else {
            throw SerializationError.missing("circuit")
        }

        // Winner
        var winnerId: String?
        var winnerName: String?
        if let winnerJson = json["winner"] as? [String: Any?] {
            winnerId = (winnerJson["driverId"] as? String? ?? nil) as String?
            if let name = winnerJson["name"] as? String, let surname = winnerJson["surname"] as? String {
                winnerName = "\(name) \(surname)"
            }
        }

        // TeamWinner
        var teamWinnerId: String?
        var teamWinnerName: String?
        if let teamWinnerJson = json["teamWinner"] as? [String: Any?] {
            teamWinnerId = (teamWinnerJson["teamId"] as? String? ?? nil)
            teamWinnerName = (teamWinnerJson["teamName"] as? String? ?? nil)
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
