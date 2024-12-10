//
//  Championship.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 18.11.2024.
//

import Foundation

public struct Championship: Codable {
    public var championshipId: String
    public var championshipName: String
    public var url: String?
    public var year: Int
}
