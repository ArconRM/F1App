//
//  SchedulePresentable.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 01.02.2025.
//

import Foundation

protocol SchedulePresentable: AnyObject, ErrorPresentable {
    func loadedNextRace(_ round: Round?)
    func loadedAllRaces(_ races: [Round?])
}
