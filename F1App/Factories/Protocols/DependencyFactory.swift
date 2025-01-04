//
//  DependencyFactory.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 03.12.2024.
//

import Foundation
import UIKit

// По примеру https://github.com/MostafaNafie/clean-mvp/blob/main/CleanMVP
protocol DependencyFactory {

    func makeScheduleViewController() -> ScheduleViewController

    func makeRoundDetailsViewController(round: Round) -> RoundDetailsViewController

    func makeDriversChampionshipViewController() -> DriversChampionshipViewController

    func makeDriverDetailsViewController(driver: Driver) -> DriverDetailsViewController

    func makeConstructorChampionshipViewController() -> ConstructorsChampionshipViewController

    func makeTeamDetailsViewController(team: Team) -> TeamDetailsViewController

    func makeSettingsViewController() -> SettingsViewController
}
