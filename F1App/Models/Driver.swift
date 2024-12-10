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
}
