//
//  ConstructorsChampionshipTableViewDelegate.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 26.12.2024.
//

import Foundation
import UIKit

class ConstructorsChampionshipTableViewDelegate: NSObject {
    
    static var rowHeight = ConstructorsChampionshipTableViewCell.cellHeight

    var items: [ConstructorsChampionshipEntry?] = []
    weak var selectionDelegate: UITableViewSelectionDelegate?

    func setItems(items: [ConstructorsChampionshipEntry?]) {
        self.items = items
    }
}

extension ConstructorsChampionshipTableViewDelegate: UITableViewDelegate {

    func numberOfSections(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ConstructorsChampionshipTableViewDelegate.rowHeight
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

extension ConstructorsChampionshipTableViewDelegate: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.constructorsChampionshipTableViewCell.rawValue, for: indexPath) as! ConstructorsChampionshipTableViewCell
        if let item = items[indexPath.row] {
            cell.configure(item: item)
        }

        cell.backgroundColor = .clear

        return cell
    }
}
