//
//  UrlSourceF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 22.11.2024.
//

import Foundation

struct UrlSourceF1Connect: UrlSource {
    let baseUrl: String = "https://f1connectapi.vercel.app/api"

    func getCurrentSeasonRacesUrl() -> String {
        return baseUrl + "/current"
    }

    func getNextSeasonRaceUrl() -> String {
        return baseUrl + "/current/next"
    }
}
