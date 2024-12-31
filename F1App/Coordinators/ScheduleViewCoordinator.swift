//
//  ScheduleViewCoordinator.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 28.12.2024.
//

import Foundation
import UIKit

class ScheduleViewCoordinator: Coordinator {
    typealias RootViewController = UINavigationController

    private let factory: DependencyFactory

    var rootViewController: RootViewController
    private let scheduleViewController: ScheduleViewController

    init(factory: DependencyFactory) {
        self.factory = factory

        scheduleViewController = factory.makeScheduleViewController()
        rootViewController = UINavigationController(rootViewController: scheduleViewController)
    }

    func start() {
        scheduleViewController.coordinator = self
    }

    func showRoundDetails(round: Round) {
        let roundDetailsVC = factory.makeRoundDetailsViewController(round: round)
        rootViewController.pushViewController(roundDetailsVC, animated: true)
    }
}
