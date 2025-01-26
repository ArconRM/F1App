//
//  UrlSource.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 22.11.2024.
//

import Foundation

protocol UrlSource {
    var baseUrl: URL { get }

    // MARK: - Races
    func getSeasonRacesUrl(year: Int?) -> URL

    /// With using current endpoint
    func getNextSeasonRaceUrl() -> URL

    // MARK: - Standings
    func getDriversChampionshipUrl(year: Int?) -> URL

    func getConstructorsChampionshipUrl(year: Int?) -> URL

    // MARK: - RoundResults
    func getPracticeResultsUrl(year: Int?, practiceNumber: Int, roundNumber: Int) -> URL
    func getSprintQualyResultsUrl(year: Int?, roundNumber: Int) -> URL
    func getSprintRaceResultsUrl(year: Int?, roundNumber: Int) -> URL
    func getQualyResultsUrl(year: Int?, roundNumber: Int) -> URL
    func getRaceResultsUrl(year: Int?, roundNumber: Int) -> URL
}
