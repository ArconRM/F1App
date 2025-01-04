//
//  AppCoordinator.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.12.2024.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    typealias RootViewController = UITabBarController

    private let factory: DependencyFactory

    var rootViewController: RootViewController

    init(rootViewController: RootViewController, factory: DependencyFactory) {
        self.rootViewController = rootViewController
        self.factory = factory
    }

    func start() {
        let scheduleCoordinator = ScheduleViewCoordinator(factory: factory)
        scheduleCoordinator.start()
        scheduleCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Расписание",
            image: UIImage(systemName: "calendar"),
            tag: 0
        )

        let driversChampionshipCoordinator = DriversChampionshipViewCoordinator(factory: factory)
        driversChampionshipCoordinator.start()
        driversChampionshipCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Личный зачёт",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        let constructorsChampionshipCoordinator = ConstructorsChampionshipViewCoordinator(factory: factory)
        constructorsChampionshipCoordinator.start()
        constructorsChampionshipCoordinator.rootViewController.tabBarItem = UITabBarItem(
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
            scheduleCoordinator.rootViewController,
            driversChampionshipCoordinator.rootViewController,
            constructorsChampionshipCoordinator.rootViewController,
            settingsNavigationVC
        ]
    }
}
