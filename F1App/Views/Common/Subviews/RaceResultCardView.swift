//
//  RaceResultCardView.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.01.2025.
//

import Foundation
import UIKit

class RaceResultCardView: UIView {

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

        addSubview(headerLabel)
        addSubview(separator)
        addSubview(resultsVStack)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            separator.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separator.heightAnchor.constraint(equalToConstant: 0.4),

            resultsVStack.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8),
            resultsVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            resultsVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            resultsVStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    // MARK: - UI Elements
    private let headerLabel = LabelFactory.createLabel(fontSize: FontSizes.header.rawValue, color: .appColor(.mainTextColor))
    private let separator = Separator()
    private let resultsVStack = StackViewFactory.createStackView(axis: .vertical, spacing: 8)

    // MARK: - Data Methods
    func configure(isSprint: Bool, raceResults: [RaceDriverResult]) {
        headerLabel.text = "Гонка \(isSprint ? " (спринт)" : "")"

        for raceDriverResult in raceResults {
            let hStackView = StackViewFactory.createStackView(axis: .horizontal)

            let positionLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))

            if let grid = raceDriverResult.grid, let position = Int(raceDriverResult.position) {
                positionLabel.text = "\(raceDriverResult.position) (\(grid - position))"
            } else {
                positionLabel.text = raceDriverResult.position
            }

            positionLabel.widthAnchor.constraint(equalToConstant: 65).isActive = true

            let driverLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor), multiline: false)
            driverLabel.text = raceDriverResult.driver.fullName

            let timeLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
            timeLabel.text = raceDriverResult.totalTime
            timeLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
            timeLabel.textAlignment = .right

            hStackView.addArrangedSubview(positionLabel)
            hStackView.addArrangedSubview(driverLabel)
            hStackView.addArrangedSubview(timeLabel)

            resultsVStack.addArrangedSubview(hStackView)
        }
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let cardView = RaceResultCardView()
    cardView.configure(isSprint: false, raceResults: RaceDriverResult.mockArray)

    let backgroundView = UIView()
    backgroundView.backgroundColor = .appColor(.backgroundPrimaryColor)
    backgroundView.addSubview(cardView)

    cardView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    cardView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true

    return backgroundView
}
