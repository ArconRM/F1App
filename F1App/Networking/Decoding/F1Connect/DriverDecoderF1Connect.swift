//
//  DriverDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 21.12.2024.
//

import Foundation

struct DriverDecoderF1Connect: DriverDecoder {

    func decodeDriver(from data: Data) throws -> Driver? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
            return try decodeDriver(from: json)
        }
        return nil
    }

    func decodeDriver(from json: [String: Any?]) throws -> Driver? {
        if let driversJson = json["driver"] as? [[String: Any?]], driversJson.count == 1 {
            return try decodeDriverFromJson(driversJson[0])
        }

        if let driverJson = json["driver"] as? [String: Any?] {
            return try decodeDriverFromJson(driverJson)
        }

        return try decodeDriverFromJson(json)
    }

    func decodeDrivers(from data: Data) throws -> [Driver] {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
            return try decodeDrivers(from: json)
        }
        return []
    }

    func decodeDrivers(from json: [String: Any?]) throws -> [Driver] {
        if let driversJsonArray = json["drivers"] as? [[String: Any?]] {

            var drivers: [Driver] = []
            for driverJson in driversJsonArray {
                drivers.append(try decodeDriverFromJson(driverJson))
            }
            return drivers
        }
        return []
    }

    private func decodeDriverFromJson(_ json: [String: Any?]) throws -> Driver {

//        guard let driverId = json["driverId"] as? String else {
//            throw SerializationError.missing(key: "driverId")
//        }
        let driverId = json["driverId"] as? String

        guard let name = json["name"] as? String else {
            throw SerializationError.missing(key: "name")
        }

        guard let surname = json["surname"] as? String else {
            throw SerializationError.missing(key: "surname")
        }

        guard let nationality = json["nationality"] as? String ?? json["country"] as? String else {
            throw SerializationError.missing(key: "nationality")
        }

        guard let birthdayString = json["birthday"] as? String else {
            throw SerializationError.missing(key: "birthday")
        }
        guard let birthday = Date.fromStringWithFormat(from: birthdayString, formatVariants: ["dd/MM/yyyy", "yyyy-MM-dd"]) else {
            throw SerializationError.invalid(key: "birthday")
        }

        let number = json["number"] as? Int

        let shortName = json["shortName"] as? String

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
