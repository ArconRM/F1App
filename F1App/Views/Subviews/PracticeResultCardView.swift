//
//  PracticeResultCardView.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 31.12.2024.
//

import Foundation
import UIKit

class PracticeResultCardView: UIView {

    private var isCollapsed: Bool = true
    private let numberOfCollapsedRows: Int = 3
    private var originalRowCount: Int {
        return resultsVStack.arrangedSubviews.count
    }

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

        addSubview(headerLabel)
        addSubview(separator)
        addSubview(resultsVStack)
        addSubview(collapseImage)

        setupConstraints()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            separator.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separator.heightAnchor.constraint(equalToConstant: 0.4),

            resultsVStack.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8),
            resultsVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            resultsVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            collapseImage.topAnchor.constraint(equalTo: resultsVStack.bottomAnchor, constant: 8),
            collapseImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            collapseImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    @objc private func handleTap() {
        isCollapsed.toggle()
        animateCollapseExpand()
    }

    private func animateCollapseExpand() {
        UIView.animate(withDuration: 0.3) {
            self.updateResultsVStackForCollapseState()
            self.layoutIfNeeded()
        }
    }

    private func updateResultsVStackForCollapseState() {
        if isCollapsed {
            for i in numberOfCollapsedRows..<originalRowCount {
                resultsVStack.arrangedSubviews[i].isHidden = true
            }
            collapseImage.image = UIImage(systemName: "chevron.down")
        } else {
            for view in resultsVStack.arrangedSubviews {
                view.isHidden = false
            }
            collapseImage.image = UIImage(systemName: "chevron.up")
        }
    }

    // MARK: - UI Elements
    private let headerLabel = LabelFactory.createLabel(fontSize: FontSizes.header.rawValue, color: .appColor(.mainTextColor))
    private let separator = Separator()
    private let resultsVStack = StackViewFactory.createStackView(axis: .vertical, spacing: 8)
    private let collapseImage = {
        let image = UIImageView(image: UIImage(systemName: "chevron.down"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .appColor(.subTextColor)
        return image
    }()

    // MARK: - Data Methods
    func configure(practiceNumber: Int, practiceResults: [PracticeDriverResult]) {
        headerLabel.text = "Практика \(practiceNumber)"

        for practiceDriverResult in practiceResults {
            let hStackView = StackViewFactory.createStackView(axis: .horizontal)

            let positionLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
            positionLabel.text = "\(practiceDriverResult.position)"
            positionLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true

            let driverLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor), multiline: false)
            driverLabel.text = practiceDriverResult.driver.fullName

            let timeLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
            timeLabel.text = practiceDriverResult.time
            timeLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
            timeLabel.textAlignment = .right

            hStackView.addArrangedSubview(positionLabel)
            hStackView.addArrangedSubview(driverLabel)
            hStackView.addArrangedSubview(timeLabel)

            resultsVStack.addArrangedSubview(hStackView)
        }

        updateResultsVStackForCollapseState()
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
    cardView.widthAnchor.constraint(equalToConstant: 360).isActive = true

    return backgroundView
}
