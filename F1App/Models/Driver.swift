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
    public var country: String
    public var birthDate: Date
    public var number: String?
    public var shortName: String
    public var url: String?
    
    init(
        driverId: String,
        name: String,
        surname: String,
        country: String,
        birthDate: Date,
        number: String?,
        shortName: String,
        url: String?
    ) {
        self.driverId = driverId
        self.name = name
        self.surname = surname
        self.country = country
        self.birthDate = birthDate
        self.number = number
        self.shortName = shortName
        self.url = url
    }
}
