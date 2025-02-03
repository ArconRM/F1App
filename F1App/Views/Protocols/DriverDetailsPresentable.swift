//
//  DriverDetailsPresentable.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 01.02.2025.
//

import Foundation

protocol DriverDetailsPresentable: AnyObject, ErrorPresentable {
    func loadedDriverDetails(_ driver: Driver)
}
