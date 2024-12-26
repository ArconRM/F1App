//
//  DriversChampionshipTableViewDelegate.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 25.12.2024.
//

import Foundation
import UIKit

class DriversChampionshipTableViewDelegate: NSObject {
    
    static var rowHeight = DriversChampionshipTableViewCell.cellHeight

    var items: [DriversChampionshipEntry?] = []
    weak var selectionDelegate: UITableViewSelectionDelegate?

    func setItems(items: [DriversChampionshipEntry?]) {
        self.items = items
    }
}

extension DriversChampionshipTableViewDelegate: UITableViewDelegate {

    func numberOfSections(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DriversChampionshipTableViewDelegate.rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionDelegate?.didSelectItem(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == items.count-1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0);
        }
    }
}

extension DriversChampionshipTableViewDelegate: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.driversChampionshipTableViewCell.rawValue, for: indexPath) as! DriversChampionshipTableViewCell
        if let item = items[indexPath.row] {
            cell.configure(item: item)
        }

        cell.backgroundColor = .clear

        return cell
    }
}
