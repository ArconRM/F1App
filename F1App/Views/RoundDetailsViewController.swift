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
        navigationController?.navigationBar.isHidden = true
        
        backgroundGradientView.frame = view.bounds

        view.addSubview(backgroundGradientView)
        view.addSubview(raceNameTitleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            raceNameTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            raceNameTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            raceNameTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    //MARK: - UI Elements
    private let backgroundGradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.colors = UIColor.appGradientColors(.mainGradientColors)
        gradientView.opacity = 0.3
        return gradientView
    }()
    
    private let raceNameTitleLabel = LabelFactory.createLabel(fontSize: 25, color: .appColor(.mainTextColor))
    
    //MARK: - Data Methods
    func loadedBaseRoundInfo(_ round: Round) {
        raceNameTitleLabel.text = round.raceName
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let factory = DependencyFactoryMock()
    let view = factory.makeRoundDetailsViewController(round: Round.mock)
    return view
}
