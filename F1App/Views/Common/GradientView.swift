//
//  GradientView.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 19.12.2024.
//

import Foundation
import UIKit

class GradientView: UIView {

    private var gradientLayer: CAGradientLayer!

    var colors: [UIColor] = [UIColor.red, UIColor.blue] {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
        }
    }

    var opacity: Float = 0.1 {
        didSet {
            gradientLayer.opacity = opacity
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientLayer()
    }

    private func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.4, y: 1.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
