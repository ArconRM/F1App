//
//  Driver.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 18.11.2024.
//

import Foundation

public struct Driver: Codable {
    public var driverId: String
    public var name: String
    public var surname: String
    public var nationality: String
    public var birthday: Date
    public var number: Int?
    public var shortName: String?
    public var url: String?

    public static var mock: Self {
        return .init(
            driverId: "1",
            name: "Driver Name",
            surname: "Drivers surname",
            nationality: "RUS",
            birthday: Date.distantPast,
            number: 69,
            shortName: "DnD"
        )
    }
}
