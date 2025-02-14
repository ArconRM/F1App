//
//  ScheduleTableViewDelegate.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 16.12.2024.
//

import Foundation
import UIKit

final class ScheduleTableViewDelegate: NSObject {

    private let estimatedRowHeightForNoWinnerCell: CGFloat = 100
    private let estimatedRowHeightForWithWinnerCell: CGFloat = 160

    var items: [Round?] = []
    weak var selectionDelegate: UITableViewSelectionDelegate?

    func setItems(items: [Round?]) {
        self.items = items
    }
}

extension ScheduleTableViewDelegate: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.section]?.winner?.name != nil ? estimatedRowHeightForWithWinnerCell : estimatedRowHeightForNoWinnerCell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionDelegate?.didSelectItem(at: indexPath.section)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ScheduleTableViewDelegate: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.scheduleTableViewCell.rawValue, for: indexPath) as! ScheduleTableViewCell
        if let item = items[indexPath.section] {
            cell.configure(item: item)
        }

        cell.backgroundColor = .clear

        return cell
    }
}
