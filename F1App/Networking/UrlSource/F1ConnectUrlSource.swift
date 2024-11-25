//
//  F1ConnectUrlSource.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 22.11.2024.
//

import Foundation

public struct F1ConnectUrlSource: UrlSource {
    public let baseUrl: String = "https://f1connectapi.vercel.app/api"
    
    public func getCurrentSeasonRacesUrl() -> String {
        return baseUrl + "/current"
    }
    public func getNextSeasonRaceUrl() -> String {
        return baseUrl + "/current/next"
    }
}
