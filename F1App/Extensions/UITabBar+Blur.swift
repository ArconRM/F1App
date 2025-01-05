//
//  UITabBar+Blur.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 05.01.2025.
//

import Foundation
import UIKit

extension UITabBar {
    static func setBackground() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()

        appearance.backgroundColor = .appColor(.tabBarBackgroundColor)
        appearance.backgroundEffect = .some(UIBlurEffect(style: .systemUltraThinMaterial))

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
    }
}
