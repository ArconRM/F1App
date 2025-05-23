//
//  TeamDetailsPresentable.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 01.02.2025.
//

import Foundation

protocol TeamDetailsPresentable: AnyObject, ErrorPresentable {
    func loadedTeamDetails(_ team: Team)
}
