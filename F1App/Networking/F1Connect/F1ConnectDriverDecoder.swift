//
//  F1ConnectDriverDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 21.12.2024.
//

import Foundation

struct F1ConnectDriverDecoder: DriverDecoder {

    func decodeDriver(from data: Data) throws -> Driver? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let driverJson = json["driver"] as? [[String: Any]], driverJson.count == 1 {

            if let driver = try decodeDriverFromJson(driverJson[0]) {
                return driver
            }
        }
        return nil
    }

    func decodeDrivers(from data: Data) throws -> [Driver?] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let driversJsonArray = json["drivers"] as? [[String: Any]] {

            var drivers: [Driver?] = []
            for driverJson in driversJsonArray {
                let driver = try decodeDriverFromJson(driverJson)
                drivers.append(driver)
            }
            return drivers
        }
        return []
    }

    private func decodeDriverFromJson(_ json: [String: Any]) throws -> Driver? {

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
            throw SerializationError.missing("nationality")
        }
        guard let birthday = Date.fromStringWithFormat(from: birthdayString, format: "yyyy-MM-dd") else {
            throw SerializationError.invalid("nationality")
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
