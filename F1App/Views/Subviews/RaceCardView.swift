//
//  RaceCardView.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 08.12.2024.
//

import UIKit

class RaceCardView: UIView {

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
        addSubview(titleLabel)
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

            titleLabel.topAnchor.constraint(equalTo: roundLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            curcuitLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            curcuitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            curcuitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            separator.topAnchor.constraint(equalTo: curcuitLabel.bottomAnchor, constant: 16),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separator.heightAnchor.constraint(equalToConstant: 1),

            noScheduleLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8),
            noScheduleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            noScheduleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            noScheduleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    // MARK: - UI Elements
    private static func createHorizontalStackView(with text: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 4

        let staticLabel = LabelFactory.createLabel(fontSize: 14, color: .appColor(.mainTextColor))
        staticLabel.text = text

        let dateLabel = LabelFactory.createLabel(fontSize: 14, color: .appColor(.mainTextColor))
        dateLabel.text = "-"

        stackView.addArrangedSubview(staticLabel)
        stackView.addArrangedSubview(dateLabel)

        return stackView
    }

    private let titleLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: 18, color: .appColor(.mainTextColor))
        label.text = "Нет данных о названии"
        return label
    }()

    private let roundLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: 14, color: .appColor(.subTextColor))
        label.text = "- этап"
        label.textAlignment = .center
        return label
    }()

    private let curcuitLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: 14, color: .appColor(.subTextColor))
        label.text = "Нет данных о трассе"
        return label
    }()

    private let noScheduleLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: 14, color: .appColor(.subTextColor))
        label.text = "Нет расписания"
        label.textAlignment = .center
        return label
    }()

    private let fp1DateStackView = createHorizontalStackView(with: "Практика 1:")
    private let fp2DateStackView = createHorizontalStackView(with: "Практика 2:")
    private let fp3DateStackView = createHorizontalStackView(with: "Практика 3:")
    private let sprintQualyDateStackView = createHorizontalStackView(with: "Спринт-квалификация:")
    private let sprintRaceDateStackView = createHorizontalStackView(with: "Спринт:")
    private let qualyDateStackView = createHorizontalStackView(with: "Квалификация:")
    private let raceDateStackView = createHorizontalStackView(with: "Гонка:")

    private let separator = Separator()

    // MARK: - Configuration Method
    func configure(race: ChampionshipRace) {
        noScheduleLabel.removeFromSuperview()

        titleLabel.text = race.raceName
        roundLabel.text = "\(race.round) этап"
        curcuitLabel.text = race.circuitName

        if let fp1Label = fp1DateStackView.arrangedSubviews[1] as? UILabel {
            fp1Label.text = race.fp1Datetime?.getDayMonthTimeWordString() ?? "-"
        }

        if let fp2Label = fp2DateStackView.arrangedSubviews[1] as? UILabel {
            fp2Label.text = race.fp2Datetime?.getDayMonthTimeWordString() ?? "-"
        }

        if let fp3Label = fp3DateStackView.arrangedSubviews[1] as? UILabel {
            fp3Label.text = race.fp3Datetime?.getDayMonthTimeWordString() ?? "-"
        }

        if let sprintQualyLabel = sprintQualyDateStackView.arrangedSubviews[1] as? UILabel {
            sprintQualyLabel.text = race.sprintQualyDatetime?.getDayMonthTimeWordString() ?? "-"
        }

        if let sprintRaceLabel = sprintRaceDateStackView.arrangedSubviews[1] as? UILabel {
            sprintRaceLabel.text = race.sprintRaceDatetime?.getDayMonthTimeWordString() ?? "-"
        }

        if let qualyLabel = qualyDateStackView.arrangedSubviews[1] as? UILabel {
            qualyLabel.text = race.qualyDatetime?.getDayMonthTimeWordString() ?? "-"
        }

        if let raceLabel = raceDateStackView.arrangedSubviews[1] as? UILabel {
            raceLabel.text = race.raceDatetime?.getDayMonthTimeWordString() ?? "-"
        }

        addSubview(fp1DateStackView)
        addSubview(fp2DateStackView)
        addSubview(fp3DateStackView)
        addSubview(sprintQualyDateStackView)
        addSubview(sprintRaceDateStackView)
        addSubview(qualyDateStackView)
        addSubview(raceDateStackView)

        setupScheduleConstraints()
    }

    func setupScheduleConstraints() {
        NSLayoutConstraint.activate([
            fp1DateStackView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8),
            fp1DateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fp1DateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            fp2DateStackView.topAnchor.constraint(equalTo: fp1DateStackView.bottomAnchor, constant: 8),
            fp2DateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fp2DateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            fp3DateStackView.topAnchor.constraint(equalTo: fp2DateStackView.bottomAnchor, constant: 8),
            fp3DateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fp3DateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            sprintQualyDateStackView.topAnchor.constraint(equalTo: fp3DateStackView.bottomAnchor, constant: 8),
            sprintQualyDateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sprintQualyDateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            sprintRaceDateStackView.topAnchor.constraint(equalTo: sprintQualyDateStackView.bottomAnchor, constant: 8),
            sprintRaceDateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sprintRaceDateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            qualyDateStackView.topAnchor.constraint(equalTo: sprintRaceDateStackView.bottomAnchor, constant: 8),
            qualyDateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            qualyDateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            raceDateStackView.topAnchor.constraint(equalTo: qualyDateStackView.bottomAnchor, constant: 8),
            raceDateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            raceDateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            raceDateStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

@available(iOS 17, *)
#Preview {
    let cardView = RaceCardView()
    cardView.configure(race: ChampionshipRace.mock)
    return cardView
}
