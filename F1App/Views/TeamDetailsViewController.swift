//
//  TeamDetailsViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 04.01.2025.
//

import Foundation
import UIKit

final class TeamDetailsViewController: BaseViewController {

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

        backgroundGradientView.frame = view.bounds

        view.addSubview(backgroundGradientView)
        view.addSubview(nameTitleLabel)
        view.addSubview(teamDetailsCardView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            teamDetailsCardView.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 16),
            teamDetailsCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            teamDetailsCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    // MARK: - UI Elements
    private let backgroundGradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.colors = UIColor.appGradientColors(.mainGradientColors)
        gradientView.opacity = 0.3
        return gradientView
    }()

    private let nameTitleLabel = LabelFactory.createLabel(fontSize: FontSizes.title.rawValue, color: .appColor(.mainTextColor))

    private let teamDetailsCardView = TeamDetailsCardView()

    // MARK: - Data Methods
    func loadedTeamDetails(team: Team) {
        nameTitleLabel.text = team.teamName
        teamDetailsCardView.configure(team: team)
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let factory = DependencyFactoryMock()
    let view = factory.makeTeamDetailsViewController(team: Team.mock)
    return view
}
