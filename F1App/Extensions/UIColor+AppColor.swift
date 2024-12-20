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
            return .adaptiveColor(light: .blue.withAlphaComponent(0.3), dark: .red.withAlphaComponent(0.8))
        
        case .backgroundSecondaryColor:
            return .adaptiveColor(light: .red.withAlphaComponent(0.3), dark: .black)
            
        case .viewsBackgroundColor:
            return .adaptiveColor(light: .white.withAlphaComponent(0.7), dark: .gray.withAlphaComponent(0.3))
        }
    }
}
