//
//  RaceScheduleCardView.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 08.12.2024.
//

import UIKit

class RaceScheduleCardView: UIView {

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

        addSubview(roundLabel)
        addSubview(headerLabel)
        addSubview(curcuitLabel)
        addSubview(separator)
        addSubview(noScheduleLabel)

        setupInitalConstraints()
    }

    private func setupInitalConstraints() {
        NSLayoutConstraint.activate([

            roundLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            roundLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            roundLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            headerLabel.topAnchor.constraint(equalTo: roundLabel.bottomAnchor, constant: 8),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            curcuitLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 4),
            curcuitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            curcuitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            separator.topAnchor.constraint(equalTo: curcuitLabel.bottomAnchor, constant: 16),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separator.heightAnchor.constraint(equalToConstant: 0.3),

            noScheduleLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8),
            noScheduleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            noScheduleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            noScheduleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    // MARK: - UI Elements
    private let headerLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: FontSizes.header.rawValue, color: .appColor(.mainTextColor))
        label.text = "Нет данных о названии"
        return label
    }()

    private let roundLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.subTextColor))
        label.text = "- этап"
        label.textAlignment = .center
        return label
    }()

    private let curcuitLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.subTextColor))
        label.text = "Нет данных о трассе"
        return label
    }()

    private let noScheduleLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.subTextColor))
        label.text = "Нет расписания"
        label.textAlignment = .center
        return label
    }()

    private let fp1DateHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Практика 1:")
    private let fp2DateHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Практика 2:")
    private let fp3DateHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Практика 3:")
    private let sprintQualyDateHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Спринт-квалификация:")
    private let sprintRaceDateHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Спринт:")
    private let qualyDateHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Квалификация:")
    private let raceDateHStackView = StackViewFactory.createHorizontalStackViewWithTwoLabels(firstText: "Гонка:")

    private let separator = Separator()

    // MARK: - Configuration Method
    func configure(round: Round) {
        noScheduleLabel.removeFromSuperview()

        headerLabel.text = round.raceName
        roundLabel.text = "\(round.round) этап"
        curcuitLabel.text = round.circuit?.name

        if let fp1Label = fp1DateHStackView.arrangedSubviews[1] as? UILabel {
            fp1Label.text = round.fp1Datetime?.getDayMonthTimeWordString() ?? "-"
        }

        if let fp2Label = fp2DateHStackView.arrangedSubviews[1] as? UILabel {
            fp2Label.text = round.fp2Datetime?.getDayMonthTimeWordString() ?? "-"
        }

        if let fp3Label = fp3DateHStackView.arrangedSubviews[1] as? UILabel {
            fp3Label.text = round.fp3Datetime?.getDayMonthTimeWordString() ?? "-"
        }

        if let sprintQualyLabel = sprintQualyDateHStackView.arrangedSubviews[1] as? UILabel {
            sprintQualyLabel.text = round.sprintQualyDatetime?.getDayMonthTimeWordString() ?? "-"
        }

        if let sprintRaceLabel = sprintRaceDateHStackView.arrangedSubviews[1] as? UILabel {
            sprintRaceLabel.text = round.sprintRaceDatetime?.getDayMonthTimeWordString() ?? "-"
        }

        if let qualyLabel = qualyDateHStackView.arrangedSubviews[1] as? UILabel {
            qualyLabel.text = round.qualyDatetime?.getDayMonthTimeWordString() ?? "-"
        }

        if let raceLabel = raceDateHStackView.arrangedSubviews[1] as? UILabel {
            raceLabel.text = round.raceDatetime?.getDayMonthTimeWordString() ?? "-"
        }

        addSubview(fp1DateHStackView)
        addSubview(fp2DateHStackView)
        addSubview(fp3DateHStackView)
        addSubview(sprintQualyDateHStackView)
        addSubview(sprintRaceDateHStackView)
        addSubview(qualyDateHStackView)
        addSubview(raceDateHStackView)

        setupScheduleConstraints()
    }

    func setupScheduleConstraints() {
        NSLayoutConstraint.activate([
            fp1DateHStackView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8),
            fp1DateHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fp1DateHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            fp2DateHStackView.topAnchor.constraint(equalTo: fp1DateHStackView.bottomAnchor, constant: 8),
            fp2DateHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fp2DateHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            fp3DateHStackView.topAnchor.constraint(equalTo: fp2DateHStackView.bottomAnchor, constant: 8),
            fp3DateHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fp3DateHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            sprintQualyDateHStackView.topAnchor.constraint(equalTo: fp3DateHStackView.bottomAnchor, constant: 8),
            sprintQualyDateHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sprintQualyDateHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            sprintRaceDateHStackView.topAnchor.constraint(equalTo: sprintQualyDateHStackView.bottomAnchor, constant: 8),
            sprintRaceDateHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sprintRaceDateHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            qualyDateHStackView.topAnchor.constraint(equalTo: sprintRaceDateHStackView.bottomAnchor, constant: 8),
            qualyDateHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            qualyDateHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            raceDateHStackView.topAnchor.constraint(equalTo: qualyDateHStackView.bottomAnchor, constant: 8),
            raceDateHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            raceDateHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            raceDateHStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let cardView = RaceScheduleCardView()
    cardView.configure(round: Round.mock)

    let backgroundView = UIView()
    backgroundView.backgroundColor = .appColor(.backgroundPrimaryColor)
    backgroundView.addSubview(cardView)

    cardView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    cardView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true

    return backgroundView
}
