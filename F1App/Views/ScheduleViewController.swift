//
//  ScheduleViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.12.2024.
//

import Foundation
import UIKit

class ScheduleViewController: BaseViewController {
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup View
    private func setupView() {
        view.addSubview(currentRaceCard)
        
        setupInitalConstraints()
    }
    
    private func setupInitalConstraints() {
        NSLayoutConstraint.activate([
            currentRaceCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            currentRaceCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currentRaceCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - UI Elements
    private static func createLabel(fontSize: Int, color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: CGFloat(fontSize))
        label.textColor = color
        return label
    }
    
    private let currentRaceCard: RaceCardView = {
        let view = RaceCardView()
        return view
    }()
    
    
    // MARK: - Data Methods
    public func loadedRace(race: ChampionshipRace?) {
        if race != nil {
            currentRaceCard.configure(race: race!)
        }
    }
}

@available(iOS 17, *)
#Preview {
    let factory = FactoryMock()
    let view = factory.makeScheduleViewController()
    view.loadedRace(race: ChampionshipRace.mock)
    return view
}
