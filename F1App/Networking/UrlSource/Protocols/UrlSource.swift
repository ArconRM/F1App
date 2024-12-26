//
//  UrlSource.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 22.11.2024.
//

import Foundation

protocol UrlSource {
    var baseUrl: String { get }

    func getCurrentSeasonRacesUrl() -> String
    func getNextSeasonRaceUrl() -> String
}
