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

    private let factory: Factory

    var rootViewController: RootViewController

    var childCoordinators: [any Coordinator]

    init(factory: Factory) {
        self.rootViewController = UITabBarController()
        
        self.childCoordinators = []
        self.factory = factory
    }

    func start() -> UIViewController {
        let scheduleVC = factory.makeScheduleViewController()
        scheduleVC.tabBarItem = UITabBarItem(
            title: "Расписание",
            image: UIImage(systemName: "calendar"),
            tag: 0
        )

        let driversChampionshipVC = factory.makeDriversChampionshipViewController()
        driversChampionshipVC.tabBarItem = UITabBarItem(
            title: "Личный зачет",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        let constructorsChampionshipVC = factory.makeConstructorChampionshipViewController()
        constructorsChampionshipVC.tabBarItem = UITabBarItem(
            title: "Командный зачет",
            image: UIImage(systemName: "person.3"),
            selectedImage: UIImage(systemName: "person.3.fill")
        )

        let settingsVC = factory.makeSettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(
            title: "Настройки",
            image: UIImage(systemName: "gear"),
            tag: 3
        )

        rootViewController.viewControllers = [scheduleVC, driversChampionshipVC, constructorsChampionshipVC, settingsVC]
        return rootViewController
    }
}
