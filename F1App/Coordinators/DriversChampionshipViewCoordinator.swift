//
//  DriversChampionshipViewCoordinator.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 04.01.2025.
//

import Foundation
import UIKit

final class DriversChampionshipViewCoordinator: Coordinator {
    typealias RootViewController = UINavigationController

    private let factory: DependencyFactory

    var rootViewController: RootViewController
    private let driversChampionshipViewController: DriversChampionshipViewController

    init(factory: DependencyFactory) {
        self.factory = factory

        driversChampionshipViewController = factory.makeDriversChampionshipViewController()
        rootViewController = UINavigationController(rootViewController: driversChampionshipViewController)
    }

    func start() {
        driversChampionshipViewController.coordinator = self
    }

    func showDriverDetails(driver: Driver) {
        let driverDetailsVC = factory.makeDriverDetailsViewController(driver: driver)
        rootViewController.pushViewController(driverDetailsVC, animated: true)
    }
}
