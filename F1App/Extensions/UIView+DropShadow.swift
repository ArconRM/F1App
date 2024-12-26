//
//  UIView+DropShadow.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 19.12.2024.
//

import Foundation
import UIKit

// https://stackoverflow.com/questions/39624675/add-shadow-on-uiview-using-swift-3
extension UIView {

    func dropShadow(color: UIColor, opacity: Float = 0.2, offSet: CGSize = .zero, radius: CGFloat = 5, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
