//
//  RoundDetailsPresentable.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 01.02.2025.
//

import Foundation

protocol RoundDetailsPresentable: AnyObject, ErrorPresentable {
    func loadedBaseRoundInfo(_ round: Round)
    func loadedRoundResultsInfo(_ roundResults: RoundResults)
}
