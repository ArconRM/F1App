//
//  RoundDetailsPresenter.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

final class RoundDetailsPresenter: Presenter {
    typealias View = RoundDetailsViewController
    
    private let roundResultsNetworkService: RoundResultsNetworkService
    
    var round: Round
    weak var view: View?
    
    init(round: Round, roundResultsNetworkService: RoundResultsNetworkService) {
        self.round = round
        self.roundResultsNetworkService = roundResultsNetworkService
    }

    func viewDidLoad() {
        view?.loadedBaseRoundInfo(round)
    }
    
//    private func 
}
