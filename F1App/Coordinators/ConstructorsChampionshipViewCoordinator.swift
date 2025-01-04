//
//  ConstructorsChampionshipViewCoordinator.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 04.01.2025.
//

import Foundation
import UIKit

final class ConstructorsChampionshipViewCoordinator: Coordinator {
    typealias RootViewController = UINavigationController

    private let factory: DependencyFactory

    let rootViewController: RootViewController
    private var constructorsChampionshipViewController: ConstructorsChampionshipViewController

    init(factory: DependencyFactory) {
        self.factory = factory

        constructorsChampionshipViewController = factory.makeConstructorChampionshipViewController()
        rootViewController = UINavigationController(rootViewController: constructorsChampionshipViewController)
    }

    func start() {
        constructorsChampionshipViewController.coordinator = self
    }

    func showTeamDetails(team: Team) {
        let teamDetailsViewController = factory.makeTeamDetailsViewController(team: team)
        rootViewController.pushViewController(teamDetailsViewController, animated: true)
    }
}
