//
//  LabelFactory.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 24.12.2024.
//

import Foundation
import UIKit

class LabelFactory {
    static func createLabel(fontSize: Int, color: UIColor, multiline: Bool = true) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: CGFloat(fontSize))
        label.textColor = color
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = multiline ? 0 : 1
        return label
    }
}
