//
//  RoundDetailsPresenter.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation

final class RoundDetailsPresenter: Presenter {
    typealias View = RoundDetailsViewController

    weak var view: View?
    var round: Round
    
    init(round: Round) {
        self.round = round
    }

    func viewDidLoad() {
        view?.loadedBaseRoundInfo(round)
    }
}
