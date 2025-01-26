//
//  UrlSourceF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 22.11.2024.
//

import Foundation

struct UrlSourceF1Connect: UrlSource {
    let baseUrl: URL = URL(string: "https://f1api.dev/api")!

    // MARK: - Races
    func getSeasonRacesUrl(year: Int?) -> URL {
        return baseUrl.appendingPathComponent((year == nil ? "/current" : "/\(year!)"))
    }

    func getNextSeasonRaceUrl() -> URL {
        return baseUrl.appendingPathComponent("/current/next")
    }

    // MARK: - Standings
    func getDriversChampionshipUrl(year: Int?) -> URL {
        return baseUrl.appendingPathComponent("/\(getYearComponent(year))/drivers-championship")
    }

    func getConstructorsChampionshipUrl(year: Int?) -> URL {
        return baseUrl.appendingPathComponent("/\(getYearComponent(year))/constructors-championship")
    }

    // MARK: - RoundResults
    func getPracticeResultsUrl(year: Int, practiceNumber: Int, roundNumber: Int) -> URL {
        return baseUrl.appendingPathComponent("/\(year)/\(roundNumber)/fp\(practiceNumber)")
    }

    func getSprintQualyResultsUrl(year: Int, roundNumber: Int) -> URL {
        return baseUrl.appendingPathComponent("/\(year)/\(roundNumber)/sprint/qualy")
    }

    func getSprintRaceResultsUrl(year: Int, roundNumber: Int) -> URL {
        return baseUrl.appendingPathComponent("/\(year)/\(roundNumber)/sprint/race")
    }

    func getQualyResultsUrl(year: Int, roundNumber: Int) -> URL {
        return baseUrl.appendingPathComponent("/\(year)/\(roundNumber)/qualy")
    }

    func getRaceResultsUrl(year: Int, roundNumber: Int) -> URL {
        return baseUrl.appendingPathComponent("/\(year)/\(roundNumber)/race")
    }

    private func getYearComponent(_ year: Int?) -> String {
        return year == nil ? "current" : "\(year!)"
    }
}
