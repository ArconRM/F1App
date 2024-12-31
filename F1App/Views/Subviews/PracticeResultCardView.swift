//
//  PracticeResultCardView.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 31.12.2024.
//

import Foundation
import UIKit

class PracticeResultCardView: UIView {
    
    // MARK: - Initializersvalue
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
            separator.heightAnchor.constraint(equalToConstant: 0.4)
        ])
    }

    // MARK: - UI Elements
    private let headerLabel = LabelFactory.createLabel(fontSize: FontSizes.header.rawValue, color: .appColor(.mainTextColor))
    private let separator = Separator()
    private let resultsVStack = StackViewFactory.createStackView(axis: .vertical, spacing: 8)
    
    // MARK: - Data Methods
    func configure(practiceNumber: Int, practiceResults: [PracticeDriverResult]) {
        headerLabel.text = "Практика \(practiceNumber)"
        
        for practiceDriverResult in practiceResults {
            let hStackView = StackViewFactory.createStackView(axis: .horizontal)
            
            let positionLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
            positionLabel.text = "\(practiceDriverResult.position)"
            
            let driverLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor), multiline: false)
            driverLabel.text = practiceDriverResult.driver.fullName
            
            let timeLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
            timeLabel.text = practiceDriverResult.time
            
            hStackView.addArrangedSubview(positionLabel)
            hStackView.addArrangedSubview(driverLabel)
            hStackView.addArrangedSubview(timeLabel)
            
            resultsVStack.addArrangedSubview(hStackView)
            
            addSubview(resultsVStack)
            
            NSLayoutConstraint.activate([
                resultsVStack.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8),
                resultsVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                resultsVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                resultsVStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
        }
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let cardView = PracticeResultCardView()
    cardView.configure(practiceNumber: 1, practiceResults: PracticeDriverResult.mockArray)

    let backgroundView = UIView()
    backgroundView.backgroundColor = .appColor(.backgroundPrimaryColor)
    backgroundView.addSubview(cardView)

    cardView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    cardView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true

    return backgroundView
}
