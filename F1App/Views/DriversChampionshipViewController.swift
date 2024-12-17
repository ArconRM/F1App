//
//  DriversChampionshipViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.12.2024.
//

import Foundation
import UIKit

class DriversChampionshipViewController: BaseViewController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }

    // MARK: - Setup View
    private func setupView() {
        self.navigationItem.title = "Личный зачёт"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
    }
}
