//
//  QualyResultsDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

protocol QualyResultsDecoder {

    func decodeQualyResults(from data: Data, isSprint: Bool) throws -> [QualyDriverResult]

    func decodeQualyResults(from json: [String: Any?], isSprint: Bool) throws -> [QualyDriverResult]
}
