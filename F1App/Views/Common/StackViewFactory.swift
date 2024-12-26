//
//  StackViewFactory.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 25.12.2024.
//

import Foundation
import UIKit

class StackViewFactory {
    static func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()

        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = .fill

        return stackView
    }
}
