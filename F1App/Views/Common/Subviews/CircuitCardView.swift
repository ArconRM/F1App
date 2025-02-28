//
//  CircuitCardView.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 28.12.2024.
//

import Foundation
import UIKit

class CircuitCardView: UIView {

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

        addSubview(nameLabel)
        addSubview(geoLabel)
        addSubview(firstParticipationHStackView)
        addSubview(lengthHStackView)
        addSubview(cornersHStackView)
        addSubview(lapRecordHStackView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            geoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            geoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            geoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            firstParticipationHStackView.topAnchor.constraint(equalTo: geoLabel.bottomAnchor, constant: 16),
            firstParticipationHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            firstParticipationHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            lengthHStackView.topAnchor.constraint(equalTo: firstParticipationHStackView.bottomAnchor, constant: 16),
            lengthHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lengthHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            cornersHStackView.topAnchor.constraint(equalTo: lengthHStackView.bottomAnchor, constant: 16),
            cornersHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cornersHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            lapRecordHStackView.topAnchor.constraint(equalTo: cornersHStackView.bottomAnchor, constant: 16),
            lapRecordHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lapRecordHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lapRecordHStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    // MARK: - UI Elements
    private let nameLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: FontSizes.header.rawValue, color: .appColor(.mainTextColor))
        label.text = "Нет данных о названии"
        return label
    }()

    private let geoLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.subTextColor))
        label.text = "Нет данных о местоположении"
        return label
    }()

    private let firstParticipationHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Год дебюта трассы: ")
    private let lengthHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Длина: ")
    private let cornersHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Повороты: ")
    private let lapRecordHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Рекорд трассы: ")

    // MARK: - Data Methods
    func configure(circuit: Circuit) {
        nameLabel.text = circuit.name
        geoLabel.text = "\(circuit.city), \(circuit.country)"

        if let lengthLabel = lengthHStackView.arrangedSubviews[1] as? UILabel {
            lengthLabel.text = circuit.length
        }

        if let cornersLabel = cornersHStackView.arrangedSubviews[1] as? UILabel {
            cornersLabel.text = circuit.numberOfCorners != nil ? "\(circuit.numberOfCorners!)" : "-"
        }

        if let lapRecordLabel = lapRecordHStackView.arrangedSubviews[1] as? UILabel {
            lapRecordLabel.text = circuit.lapRecord ?? "-"
        }

        if let firstParticipationYearLabel = firstParticipationHStackView.arrangedSubviews[1] as? UILabel {
            firstParticipationYearLabel.text = circuit.firstParticipationYear != nil ? "\(circuit.firstParticipationYear!)" : "-"
        }
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let cardView = CircuitCardView()
    cardView.configure(circuit: Circuit.mock)

    let backgroundView = UIView()
    backgroundView.backgroundColor = .appColor(.backgroundPrimaryColor)
    backgroundView.addSubview(cardView)

    cardView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    cardView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true

    return backgroundView
}
