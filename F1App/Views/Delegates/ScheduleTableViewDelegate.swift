//
//  ScheduleTableViewDelegate.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 16.12.2024.
//

import Foundation
import UIKit

class ScheduleTableViewDelegate: NSObject {

    static var rowHeight = 120

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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let item = items[indexPath.section], item.winner?.name != nil {
            return ScheduleTableViewCell.cellHeightFull
        } else {
            return ScheduleTableViewCell.cellHeightWithoutWinner
        }
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
        selectionDelegate?.didSelectItem(at: indexPath.row)
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

        cell.backgroundColor = .appColor(.viewsBackgroundColor)

        let maskPath = UIBezierPath(
            roundedRect: CGRect(origin: cell.bounds.origin, size: cell.bounds.size),
            byRoundingCorners: [.topLeft, .topRight, .bottomRight, .bottomLeft],
            cornerRadii: CGSize(width: 10, height: 10)
        )

        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(origin: cell.bounds.origin, size: cell.bounds.size)
        shapeLayer.path = maskPath.cgPath
        cell.layer.mask = shapeLayer

        return cell
    }
}
