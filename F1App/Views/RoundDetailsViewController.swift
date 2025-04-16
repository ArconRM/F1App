//
//  RoundDetailsViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation
import UIKit

final class RoundDetailsViewController: BaseViewController<RoundDetailsPresenter>, RoundDetailsPresentable {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        presenter.viewDidLoad()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection!) {
            backgroundGradientView.colors = UIColor.appGradientColors(.mainGradientColors)
        }
    }

    // MARK: - Setup View
    private func setupView() {
        view.backgroundColor = .adaptiveColor(light: .white, dark: .black)

        view.addSubview(backgroundGradientView)
        view.addSubview(raceNameTitleLabel)
        view.addSubview(scrollView)

        scrollView.addSubview(scrollContainerView)

        scrollContainerView.addArrangedSubview(circuitCardView)
        scrollContainerView.addArrangedSubview(loadingLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundGradientView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundGradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            raceNameTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            raceNameTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            raceNameTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            scrollView.topAnchor.constraint(equalTo: raceNameTitleLabel.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            scrollContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            circuitCardView.topAnchor.constraint(equalTo: scrollContainerView.topAnchor, constant: 16),
            circuitCardView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            circuitCardView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),

            loadingLabel.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            loadingLabel.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16)
        ])
    }

    // MARK: - UI Elements
    private let backgroundGradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.colors = UIColor.appGradientColors(.mainGradientColors)
        gradientView.opacity = 0.3
        return gradientView
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()

    private let scrollContainerView = StackViewFactory.createStackView(axis: .vertical, alignment: .center, spacing: 16)

    private let raceNameTitleLabel = LabelFactory.createLabel(fontSize: FontSizes.title.rawValue, color: .appColor(.mainTextColor))

    private let circuitCardView = CircuitCardView()

    private let fp1ResultCardView = PracticeResultCardView()
    private let fp2ResultCardView = PracticeResultCardView()
    private let fp3ResultCardView = PracticeResultCardView()

    private let sprintQualyResultCardView = QualyResultCardView()
    private let sprintRaceResultCardView = RaceResultCardView()

    private let qualyResultCardView = QualyResultCardView()
    private let raceResultCardView = RaceResultCardView()

    private let loadingLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.subTextColor))
        label.text = "Загрузка..."
        label.textAlignment = .center
        return label
    }()

    // MARK: - Data Methods
    func loadedBaseRoundInfo(_ round: Round) {
        raceNameTitleLabel.text = round.raceName

        if round.circuit != nil {
            circuitCardView.configure(circuit: round.circuit!)
        }
    }

    func loadedRoundResultsInfo(_ roundResults: RoundResults) {
        loadingLabel.removeFromSuperview()

        if !roundResults.fp1Results.isEmpty {
            fp1ResultCardView.configure(practiceNumber: 1, practiceResults: roundResults.fp1Results)

            scrollContainerView.addArrangedSubview(fp1ResultCardView)
            fp1ResultCardView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16).isActive = true
            fp1ResultCardView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16).isActive = true
        }
        if !roundResults.fp2Results.isEmpty {
            fp2ResultCardView.configure(practiceNumber: 2, practiceResults: roundResults.fp2Results)

            scrollContainerView.addArrangedSubview(fp2ResultCardView)
            fp2ResultCardView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16).isActive = true
            fp2ResultCardView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16).isActive = true
        }
        if !roundResults.fp3Results.isEmpty {
            fp3ResultCardView.configure(practiceNumber: 3, practiceResults: roundResults.fp3Results)

            scrollContainerView.addArrangedSubview(fp3ResultCardView)
            fp3ResultCardView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16).isActive = true
            fp3ResultCardView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16).isActive = true
        }

        if !roundResults.sprintQualyResults.isEmpty {
            sprintQualyResultCardView.configure(isSprint: true, qualyResults: roundResults.sprintQualyResults)

            scrollContainerView.addArrangedSubview(sprintQualyResultCardView)
            sprintQualyResultCardView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16).isActive = true
            sprintQualyResultCardView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16).isActive = true
        }
        if !roundResults.sprintRaceResults.isEmpty {
            sprintRaceResultCardView.configure(isSprint: true, raceResults: roundResults.sprintRaceResults)

            scrollContainerView.addArrangedSubview(sprintRaceResultCardView)
            sprintRaceResultCardView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16).isActive = true
            sprintRaceResultCardView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16).isActive = true
        }

        if !roundResults.qualyResults.isEmpty {
            qualyResultCardView.configure(isSprint: false, qualyResults: roundResults.qualyResults)

            scrollContainerView.addArrangedSubview(qualyResultCardView)
            qualyResultCardView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16).isActive = true
            qualyResultCardView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16).isActive = true
        }
        if !roundResults.raceResults.isEmpty {
            raceResultCardView.configure(isSprint: false, raceResults: roundResults.raceResults)

            scrollContainerView.addArrangedSubview(raceResultCardView)
            raceResultCardView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16).isActive = true
            raceResultCardView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16).isActive = true
        }
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let factory = DependencyFactoryWithMockData()
    let view = factory.makeRoundDetailsViewController(round: Round.mock)
    return view
}
