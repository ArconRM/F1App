//
//  QualyResultsDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

protocol QualyResultsDecoder {
    
    func decodeQualyResults(data: Data, isSprint: Bool) throws -> [QualyDriverResult]
    
    func decodeQualyResults(json: [String: Any], isSprint: Bool) throws -> [QualyDriverResult]
}

