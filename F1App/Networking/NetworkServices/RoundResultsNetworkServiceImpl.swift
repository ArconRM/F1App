//
//  RoundResultsNetworkServiceImpl.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 28.12.2024.
//

import Foundation

struct RoundResultsNetworkServiceImpl: RoundResultsNetworkService {
    private let urlSource: UrlSource

    private let practiceResultDecoder: PracticeResultsDecoder
    private let qualyResultDecoder: QualyResultsDecoder
    private let raceResultDecoder: RaceResultsDecoder

    init(
        urlSource: UrlSource,
        practiceResultDecoder: PracticeResultsDecoder,
        qualyResultDecoder: QualyResultsDecoder,
        raceResultDecoder: RaceResultsDecoder
    ) {
        self.urlSource = urlSource
        self.practiceResultDecoder = practiceResultDecoder
        self.qualyResultDecoder = qualyResultDecoder
        self.raceResultDecoder = raceResultDecoder
    }

    func fetchRoundResults(round: Round, resultQueue: DispatchQueue, completionHandler: @escaping (Result<RoundResults, any Error>) -> Void) {
        fatalError("Not implemented")
    }
}
