//
//  PracticeResultsDecoder.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

protocol PracticeResultsDecoder {

    func decodePracticeResults(from data: Data, practiceNumber: Int) throws -> [PracticeDriverResult]

    func decodePracticeResults(from json: [String: Any?], practiceNumber: Int) throws -> [PracticeDriverResult]
}
