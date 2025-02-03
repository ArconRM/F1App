//
//  DriverDetailsCardView.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 04.01.2025.
//

import Foundation
import UIKit

class DriverDetailsCardView: UIView {

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
        addSubview(numberHStackView)
        addSubview(shortNameHStackView)
        addSubview(birthdateHStackView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            countryHStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            countryHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            countryHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            numberHStackView.topAnchor.constraint(equalTo: countryHStackView.bottomAnchor, constant: 8),
            numberHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            numberHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            shortNameHStackView.topAnchor.constraint(equalTo: numberHStackView.bottomAnchor, constant: 8),
            shortNameHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            shortNameHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            birthdateHStackView.topAnchor.constraint(equalTo: shortNameHStackView.bottomAnchor, constant: 8),
            birthdateHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            birthdateHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            birthdateHStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    // MARK: - UI Elements
    private let countryHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Страна: ")
    private let numberHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Номер: ")
    private let shortNameHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Сокращенное имя: ")
    private let birthdateHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Дата рождения: ")

    // MARK: - Data Methods
    func configure(driver: Driver) {
        if let countryLabel = countryHStackView.arrangedSubviews[1] as? UILabel {
            countryLabel.text = driver.nationality
        }

        if let numberLabel = numberHStackView.arrangedSubviews[1] as? UILabel {
            if let number = driver.number {
                numberLabel.text = "\(number)"
            } else {
                numberLabel.text = "-"
            }
        }

        if let shortNameLabel = shortNameHStackView.arrangedSubviews[1] as? UILabel {
            shortNameLabel.text = driver.shortName
        }

        if let birthdateLabel = birthdateHStackView.arrangedSubviews[1] as? UILabel {
            birthdateLabel.text = driver.birthday.getFullDateString()
        }
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let cardView = DriverDetailsCardView()
    cardView.configure(driver: Driver.mock)

    let backgroundView = UIView()
    backgroundView.backgroundColor = .appColor(.backgroundPrimaryColor)
    backgroundView.addSubview(cardView)

    cardView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    cardView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true

    return backgroundView
}
