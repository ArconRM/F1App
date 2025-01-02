//
//  StackViewFactory.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 25.12.2024.
//

import Foundation
import UIKit

class StackViewFactory {
    static func createStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0) -> UIStackView {
        let stackView = UIStackView()

        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.distribution = .equalSpacing
        stackView.spacing = spacing
        stackView.alignment = .fill

        return stackView
    }

    static func createHorizontalStackViewWithTwoLabels(firstText text: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 4

        let staticLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
        staticLabel.text = text

        let dataLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
        dataLabel.text = "-"

        stackView.addArrangedSubview(staticLabel)
        stackView.addArrangedSubview(dataLabel)

        return stackView
    }

}
