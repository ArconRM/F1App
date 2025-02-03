//
//  DriversChampionshipPresentable.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 01.02.2025.
//

import Foundation

protocol DriversChampionshipPresentable: AnyObject, ErrorPresentable {
    func loadedDriversChampionship(_ driversChampionship: [DriversChampionshipEntry?])
}
