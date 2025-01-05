//
//  UIColor+AppColor.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 19.12.2024.
//

import Foundation
import UIKit

extension UIColor {
    static func appColor(_ name: Colors) -> UIColor {
        switch name {
        case .mainTextColor:
            return .adaptiveColor(light: .black, dark: .white)

        case .subTextColor:
            return .adaptiveColor(light: .darkGray, dark: .lightGray)

        case .backgroundPrimaryColor:
            return .adaptiveColor(light: .systemTeal.withAlphaComponent(0.4), dark: .systemTeal.withAlphaComponent(0.3))

        case .backgroundSecondaryColor:
            return .adaptiveColor(light: .systemIndigo.withAlphaComponent(0.5), dark: .systemIndigo.withAlphaComponent(0.3))

        case .viewsBackgroundColor:
            return .adaptiveColor(light: .white.withAlphaComponent(0.7), dark: .gray.withAlphaComponent(0.3))
        }
    }

    static func appGradientColors(_ name: GradientColors) -> [UIColor] {
        switch name {
        case .mainGradientColors:
            return [
                .appColor(.backgroundSecondaryColor),
                .appColor(.backgroundPrimaryColor),
                .appColor(.backgroundSecondaryColor)
            ]
        }
    }
}
