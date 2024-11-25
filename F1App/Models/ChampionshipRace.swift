//
//  ChampionshipRace.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 20.11.2024.
//

import Foundation

//https://developer.apple.com/swift/blog/?id=37
//TODO: Мб все таки сделать сущности отдельные для
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
    public var raceDatetime: Date?
    public var qualyDatetime: Date?
    public var fp1Datetime: Date?
    public var fp2Datetime: Date?
    public var fp3Datetime: Date?
    public var sprintQualyDatetime: Date?
    public var sprintRaceDatetime: Date?
}

extension ChampionshipRace {
    init?(json: [String: Any?]) throws {
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
            winnerName = (winnerJson["name"] as? String? ?? nil) as String?
        }
       
        
//      TeamWinner
        var teamWinnerId: String? = nil
        var teamWinnerName: String? = nil
        if let teamWinnerJson = json["teamWinner"] as? [String: Any?] {
            teamWinnerId = (teamWinnerJson["teamId"] as? String? ?? nil)
            teamWinnerName = (teamWinnerJson["teamName"] as? String? ?? nil)
        }
       
        
        self.raceId = raceId
        self.raceName = raceName
        self.laps = laps
        self.round = round
        self.url = url
        
        self.circuitId = circuitId
        self.circuitName = circuitName
        
        self.winnerId = winnerId
        self.winnerName = winnerName
        
        self.teamWinnerId = teamWinnerId
        self.teamWinnerName = teamWinnerName
        
        self.raceDatetime = getDateTime(date: raceDate, time: raceTime)
        self.qualyDatetime = getDateTime(date: qualyDate, time: qualyTime)
        self.fp1Datetime = getDateTime(date: fp1Date, time: fp1Time)
        self.fp2Datetime = getDateTime(date: fp2Date, time: fp2Time)
        self.fp3Datetime = getDateTime(date: fp3Date, time: fp3Time)
        self.sprintQualyDatetime = getDateTime(date: sprintQualyDate, time: sprintQualyTime)
        self.sprintRaceDatetime = getDateTime(date: sprintRaceDate, time: sprintRaceTime)
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
