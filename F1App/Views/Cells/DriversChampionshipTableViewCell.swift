//
//  DriversChampionshipTableViewCell.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 24.12.2024.
//

import Foundation
import UIKit

class DriversChampionshipTableViewCell: UITableViewCell {

    static let cellHeight: CGFloat = 80

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup View
    private func setupViews() {
        contentView.addSubview(mainHStackView)

        mainHStackView.addSubview(positionLabel)
        mainHStackView.addSubview(labelsVStackView)
        mainHStackView.addSubview(pointsLabel)

        labelsVStackView.addSubview(fullNameLabel)
        labelsVStackView.addSubview(teamNameLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: DriversChampionshipTableViewCell.cellHeight),

            mainHStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainHStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainHStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainHStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            positionLabel.topAnchor.constraint(equalTo: mainHStackView.topAnchor),
            positionLabel.leadingAnchor.constraint(equalTo: mainHStackView.leadingAnchor, constant: 16),
            positionLabel.centerYAnchor.constraint(equalTo: mainHStackView.centerYAnchor),
            positionLabel.widthAnchor.constraint(equalToConstant: 24),

            labelsVStackView.topAnchor.constraint(equalTo: mainHStackView.topAnchor),
            labelsVStackView.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor, constant: 22),
            labelsVStackView.bottomAnchor.constraint(equalTo: mainHStackView.bottomAnchor),

            fullNameLabel.topAnchor.constraint(equalTo: labelsVStackView.topAnchor, constant: 2),
            fullNameLabel.leadingAnchor.constraint(equalTo: labelsVStackView.leadingAnchor),
            fullNameLabel.trailingAnchor.constraint(equalTo: labelsVStackView.trailingAnchor),

            teamNameLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            teamNameLabel.leadingAnchor.constraint(equalTo: labelsVStackView.leadingAnchor),
            teamNameLabel.trailingAnchor.constraint(equalTo: labelsVStackView.trailingAnchor),

            pointsLabel.topAnchor.constraint(equalTo: mainHStackView.topAnchor),
            pointsLabel.trailingAnchor.constraint(equalTo: mainHStackView.trailingAnchor, constant: -16),
            pointsLabel.bottomAnchor.constraint(equalTo: mainHStackView.bottomAnchor)
        ])
    }

    // MARK: - UI Elements
    private let positionLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
    private let fullNameLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
    private let teamNameLabel = LabelFactory.createLabel(fontSize: FontSizes.caption.rawValue, color: .appColor(.subTextColor))
    private let pointsLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))

    private let mainHStackView = StackViewFactory.createStackView(axis: .horizontal)
    private let labelsVStackView = StackViewFactory.createStackView(axis: .vertical)

    // MARK: - Data Methods
    func configure(item: DriversChampionshipEntry) {
        positionLabel.text = "\(item.position)"
        fullNameLabel.text = "\(item.driver.fullName)"
        teamNameLabel.text = "\(item.team.teamName)"
        pointsLabel.text = "\(item.points)"
    }
}
