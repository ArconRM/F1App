//
//  Factory.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 03.12.2024.
//

import Foundation
import UIKit

// По примеру https://github.com/MostafaNafie/clean-mvp/blob/main/CleanMVP
protocol Factory {
    
    func makeScheduleViewController() -> ScheduleViewController

    func makeDriversChampionshipViewController() -> DriversChampionshipViewController

    func makeConstructorChampionshipViewController() -> ConstructorChampionshipViewController

    func makeSettingsViewController() -> SettingsViewController
}
