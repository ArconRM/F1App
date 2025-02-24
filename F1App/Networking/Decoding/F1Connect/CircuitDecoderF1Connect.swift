//
//  CircuitDecoderF1Connect.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 28.12.2024.
//

import Foundation

struct CircuitDecoderF1Connect: CircuitDecoder {

    func decodeCircuit(from data: Data) throws -> Circuit? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
            return try decodeCircuit(from: json)
        }
        return nil
    }

    func decodeCircuit(from json: [String: Any?]) throws -> Circuit? {
        if let circuitsJson = json["circuit"] as? [[String: Any?]], circuitsJson.count == 1 {
            return try decodeCircuitFromJson(circuitsJson[0])
        }

        if let circuitJson = json["circuit"] as? [String: Any?] {
            return try decodeCircuitFromJson(circuitJson)
        }

        return try decodeCircuitFromJson(json)
    }

    private func decodeCircuitFromJson(_ json: [String: Any?]) throws -> Circuit {
        guard let circuitId = json["circuitId"] as? String else {
            throw SerializationError.missing(key: "circuitId")
        }

        guard let name = json["circuitName"] as? String else {
            throw SerializationError.missing(key: "name")
        }

        guard let country = json["country"] as? String else {
            throw SerializationError.missing(key: "country")
        }

        guard let city = json["city"] as? String else {
            throw SerializationError.missing(key: "city")
        }

        guard let length = json["circuitLength"] as? String else {
            throw SerializationError.missing(key: "length")
        }

        let lapRecord = json["lapRecord"] as? String
        let firstParticipationYear = json["firstParticipationYear"] as? Int

        let corners = json["corners"] as? Int
        let url = json["url"] as? String

        return Circuit(
            circuitId: circuitId,
            name: name,
            country: country,
            city: city,
            length: length,
            lapRecord: lapRecord,
            firstParticipationYear: firstParticipationYear,
            numberOfCorners: corners,
            url: url
        )
    }
}
