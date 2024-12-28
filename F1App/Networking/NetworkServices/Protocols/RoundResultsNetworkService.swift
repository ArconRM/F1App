//
//  RoundResultsNetworkService.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

protocol RoundResultsNetworkService {
    func fetchRoundResults(
        round: Round,
        resultQueue: DispatchQueue,
        completionHandler: @escaping (Result<RoundResults, Error>) -> Void
    )
}
