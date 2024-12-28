//
//  DriverDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 21.12.2024.
//

import Foundation

protocol DriverDecoder {

    func decodeDriver(from data: Data) throws -> Driver?

    func decodeDriver(from json: [String: Any?]) throws -> Driver?

    func decodeDrivers(from data: Data) throws -> [Driver]

    func decodeDrivers(from json: [String: Any?]) throws -> [Driver]

}
