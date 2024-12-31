//
//  RoundDetailsViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 27.12.2024.
//

import Foundation
import UIKit

class RoundDetailsViewController: BaseViewController {

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
        view.addSubview(raceNameTitleLabel)
        view.addSubview(scrollView)

        scrollView.addSubview(scrollContainerView)
        
        scrollContainerView.addSubview(circuitCardView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            raceNameTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            raceNameTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            raceNameTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: raceNameTitleLabel.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            scrollContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            circuitCardView.topAnchor.constraint(equalTo: scrollContainerView.topAnchor, constant: 16),
            circuitCardView.leadingAnchor.constraint(equalTo: scrollContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            circuitCardView.trailingAnchor.constraint(equalTo: scrollContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }

    // MARK: - UI Elements
    private let backgroundGradientView: GradientView = {
        let gradientView = GradientView()
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

    private let scrollContainerView: UIView = {
        let scrollContainerView = UIView()
        scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
        return scrollContainerView
    }()

    private let raceNameTitleLabel = LabelFactory.createLabel(fontSize: FontSizes.title.rawValue, color: .appColor(.mainTextColor))

    private let circuitCardView = CircuitCardView()
    private let fp1ResultCardView = PracticeResultCardView()
    private let fp2ResultCardView = PracticeResultCardView()
    private let fp3ResultCardView = PracticeResultCardView()

    // MARK: - Data Methods
    func loadedBaseRoundInfo(_ round: Round) {
        raceNameTitleLabel.text = round.raceName

        if round.circuit != nil {
            circuitCardView.configure(circuit: round.circuit!)
        }
    }
    
    func loadedRoundResultsInfo(_ roundResults: RoundResults) {
        fp1ResultCardView.configure(practiceNumber: 1, practiceResults: roundResults.fp1Results)
        fp2ResultCardView.configure(practiceNumber: 2, practiceResults: roundResults.fp2Results)
        fp3ResultCardView.configure(practiceNumber: 3, practiceResults: roundResults.fp3Results)
        
        scrollContainerView.addSubview(fp1ResultCardView)
        scrollContainerView.addSubview(fp2ResultCardView)
        scrollContainerView.addSubview(fp3ResultCardView)
        
        NSLayoutConstraint.activate([
            fp1ResultCardView.topAnchor.constraint(equalTo: circuitCardView.bottomAnchor, constant: 16),
            fp1ResultCardView.leadingAnchor.constraint(equalTo: scrollContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            fp1ResultCardView.trailingAnchor.constraint(equalTo: scrollContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            fp2ResultCardView.topAnchor.constraint(equalTo: fp1ResultCardView.bottomAnchor, constant: 16),
            fp2ResultCardView.leadingAnchor.constraint(equalTo: scrollContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            fp2ResultCardView.trailingAnchor.constraint(equalTo: scrollContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            fp3ResultCardView.topAnchor.constraint(equalTo: fp2ResultCardView.bottomAnchor, constant: 16),
            fp3ResultCardView.leadingAnchor.constraint(equalTo: scrollContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            fp3ResultCardView.trailingAnchor.constraint(equalTo: scrollContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            fp3ResultCardView.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let factory = DependencyFactoryMock()
    let view = factory.makeRoundDetailsViewController(round: Round.mock)
    return view
}
