//
//  DriverDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 21.12.2024.
//

import Foundation

struct DriverDecoderF1Connect: DriverDecoder {

    func decodeDriver(from data: Data) throws -> Driver? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return try decodeDriver(from: json)
        }
        return nil
    }

    func decodeDriver(from json: [String: Any]) throws -> Driver? {
        if let driversJson = json["driver"] as? [[String: Any]], driversJson.count == 1 {
            return try decodeDriverFromJson(driversJson[0])
        }

        if let driverJson = json["driver"] as? [String: Any] {
            return try decodeDriverFromJson(driverJson)
        }

        return nil
    }

    func decodeDrivers(from data: Data) throws -> [Driver?] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return try decodeDrivers(from: json)
        }
        return []
    }

    func decodeDrivers(from json: [String: Any]) throws -> [Driver?] {
        if let driversJsonArray = json["drivers"] as? [[String: Any]] {

            var drivers: [Driver?] = []
            for driverJson in driversJsonArray {
                drivers.append(try decodeDriverFromJson(driverJson))
            }
            return drivers
        }
        return []
    }

    private func decodeDriverFromJson(_ json: [String: Any]) throws -> Driver {

        guard let driverId = (json["driverId"] as? String? ?? nil) as String? else {
            throw SerializationError.missing("driverId")
        }

        guard let name = (json["name"] as? String? ?? nil) as String? else {
            throw SerializationError.missing("name")
        }

        guard let surname = (json["surname"] as? String? ?? nil) as String? else {
            throw SerializationError.missing("surname")
        }

        guard let nationality = (json["nationality"] as? String? ?? nil) as String? else {
            throw SerializationError.missing("nationality")
        }

        guard let birthdayString = (json["birthday"] as? String? ?? nil) as String? else {
            throw SerializationError.missing("birthday")
        }
        guard let birthday = Date.fromStringWithFormat(from: birthdayString, formatVariants: ["dd/MM/yyyy", "yyyy-MM-dd"]) else {
            throw SerializationError.invalid("birthday")
        }

        let number = (json["number"] as? Int? ?? nil) as Int?

        let shortName = (json["shortName"] as? String? ?? nil) as String?

        return Driver(
            driverId: driverId,
            name: name,
            surname: surname,
            nationality: nationality,
            birthday: birthday,
            number: number,
            shortName: shortName
        )
    }
}
