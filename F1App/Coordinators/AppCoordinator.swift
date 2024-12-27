//
//  AppCoordinator.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.12.2024.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    typealias RootViewController = UITabBarController

    private let factory: DependencyFactory

    var rootViewController: RootViewController

    var childCoordinators: [any Coordinator]

    init(factory: DependencyFactory) {
        self.rootViewController = UITabBarController()

        self.childCoordinators = []
        self.factory = factory
    }

    func start() -> UIViewController {
        let scheduleVC = factory.makeScheduleViewController()
        let scheduleNavigationVC = UINavigationController(rootViewController: scheduleVC)
        scheduleNavigationVC.tabBarItem = UITabBarItem(
            title: "Расписание",
            image: UIImage(systemName: "calendar"),
            tag: 0
        )

        let driversChampionshipVC = factory.makeDriversChampionshipViewController()
        let driversChampionshipNavigationVC = UINavigationController(rootViewController: driversChampionshipVC)
        driversChampionshipNavigationVC.tabBarItem = UITabBarItem(
            title: "Личный зачёт",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        let constructorsChampionshipVC = factory.makeConstructorChampionshipViewController()
        let constructorsChampionshipNavigationVC = UINavigationController(rootViewController: constructorsChampionshipVC)
        constructorsChampionshipVC.tabBarItem = UITabBarItem(
            title: "Командный зачет",
            image: UIImage(systemName: "person.3"),
            selectedImage: UIImage(systemName: "person.3.fill")
        )

        let settingsVC = factory.makeSettingsViewController()
        let settingsNavigationVC = UINavigationController(rootViewController: settingsVC)
        settingsVC.tabBarItem = UITabBarItem(
            title: "Настройки",
            image: UIImage(systemName: "gear"),
            tag: 3
        )

        rootViewController.viewControllers = [
            scheduleNavigationVC,
            driversChampionshipNavigationVC,
            constructorsChampionshipNavigationVC,
            settingsNavigationVC
        ]
        return rootViewController
    }
}
