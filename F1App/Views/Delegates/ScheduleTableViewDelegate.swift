//
//  ScheduleTableViewDelegate.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 16.12.2024.
//

import Foundation
import UIKit

class ScheduleTableViewDelegate: NSObject {
    
    public static let rowHeight = 150

    var items: [ChampionshipRace?]
    weak var selectionDelegate: UITableViewSelectionDelegate?

    init(items: [ChampionshipRace?]) {
        self.items = items
        super.init()
    }
}

extension ScheduleTableViewDelegate: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(ScheduleTableViewDelegate.rowHeight)
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
            cell.titleLabel.text = item.raceName
            cell.curcuitLabel.text = item.circuitName
            
            if let fp1Datetime = item.fp1Datetime, let raceDatetime = item.raceDatetime {
                cell.dateLabel.text = "\(fp1Datetime.getDayMonthString()) - \(raceDatetime.getDayMonthString())"
            } else {
                cell.dateLabel.text = "Нет даты"
            }
            
            if let winnerName = item.winnerName {
                cell.winnerLabel.text = "Победитель: \(winnerName)"
            }
            
        } else {
            cell.titleLabel.text = "Нет инфорфмации о гонке"
        }
        return cell
    }
}
