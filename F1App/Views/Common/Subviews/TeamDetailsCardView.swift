//
//  TeamDetailsCardView.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 04.01.2025.
//

import Foundation
import UIKit

final class TeamDetailsCardView: UIView {

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup View
    private func setupView() {
        backgroundColor = .appColor(.viewsBackgroundColor)
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 10

        addSubview(countryHStackView)
        addSubview(constructorsChampionshipsHStackView)
        addSubview(driversChampionshipsHStackView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            countryHStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            countryHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            countryHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            constructorsChampionshipsHStackView.topAnchor.constraint(equalTo: countryHStackView.bottomAnchor, constant: 8),
            constructorsChampionshipsHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            constructorsChampionshipsHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            driversChampionshipsHStackView.topAnchor.constraint(equalTo: constructorsChampionshipsHStackView.bottomAnchor, constant: 8),
            driversChampionshipsHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            driversChampionshipsHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            driversChampionshipsHStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    // MARK: - UI Elements
    private let countryHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Страна: ")
    private let constructorsChampionshipsHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Кубков конструкторов: ")
    private let driversChampionshipsHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Чемпионы мира: ")

    // MARK: - Data Methods
    func configure(team: Team) {
        if let countryLabel = countryHStackView.arrangedSubviews[1] as? UILabel {
            countryLabel.text = team.country
        }

        if let constructorsChampionshipsLabel = constructorsChampionshipsHStackView.arrangedSubviews[1] as? UILabel {
            if let constructorsChampionships = team.constructorsChampionships {
                constructorsChampionshipsLabel.text = "\(constructorsChampionships)"
            } else {
                constructorsChampionshipsLabel.text = "-"
            }
        }

        if let driversChampionshipsLabel = driversChampionshipsHStackView.arrangedSubviews[1] as? UILabel {
            if let driversChampionships = team.driversChampionships {
                driversChampionshipsLabel.text = "\(driversChampionships)"
            } else {
                driversChampionshipsLabel.text = "-"
            }
        }
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let cardView = TeamDetailsCardView()
    cardView.configure(team: Team.mock)

    let backgroundView = UIView()
    backgroundView.backgroundColor = .appColor(.backgroundPrimaryColor)
    backgroundView.addSubview(cardView)

    cardView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    cardView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true

    return backgroundView
}
