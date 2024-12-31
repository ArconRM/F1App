//
//  Separator.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 17.12.2024.
//

import Foundation
import UIKit

class Separator: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .gray
    }
}
