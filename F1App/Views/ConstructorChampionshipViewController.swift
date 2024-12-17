//
//  ConstructorChampionshipViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation
import UIKit

class ConstructorChampionshipViewController: BaseViewController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }

    // MARK: - Setup View
    private func setupView() {
        self.navigationItem.title = "Командный зачёт"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
    }
}
