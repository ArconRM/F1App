//
//  Driver.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 18.11.2024.
//

import Foundation

struct Driver: Codable {
    var driverId: String
    var name: String
    var surname: String
    var nationality: String
    var birthday: Date
    var number: Int?
    var shortName: String?
    var url: String?

    var fullName: String {
        "\(name) \(surname)"
    }

    static var mock: Self {
        return .init(
            driverId: "1",
            name: "Name",
            surname: "Surname",
            nationality: "RUS",
            birthday: Date.distantPast,
            number: 69,
            shortName: "DnD"
        )
    }
}
