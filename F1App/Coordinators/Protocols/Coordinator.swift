//
//  Coordinator.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.12.2024.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    associatedtype RootViewController: UIViewController

    var rootViewController: RootViewController { get }
    var childCoordinators: [any Coordinator] { get set }

    func start() -> UIViewController

    func addChildCoordinator(_ coordinator: any Coordinator)
    func removeChildCoordinator(_ coordinator: any Coordinator)
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: any Coordinator) {
        if !childCoordinators.contains(where: { $0 !== coordinator }) {
            childCoordinators.append(coordinator)
        }
    }

    func removeChildCoordinator(_ coordinator: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
