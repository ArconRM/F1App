//
//  ScheduleViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.12.2024.
//

import Foundation
import UIKit

class ScheduleViewController: BaseViewController {

    private var scheduleTableViewDelegate: ScheduleTableViewDelegate?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }

    // MARK: - Setup View
    private func setupView() {
        self.navigationItem.title = "Расписание"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isTranslucent = false

        scheduleTableView.isHidden = true

        view.addSubview(scrollView)
        scrollView.addSubview(scrollContainerView)
        scrollContainerView.addSubview(nextRaceTitleLabel)
        scrollContainerView.addSubview(currentRaceCard)
        scrollContainerView.addSubview(separator)
        scrollContainerView.addSubview(noScheduleLabel)
        scrollContainerView.addSubview(scheduleTitleLabel)
        scrollContainerView.addSubview(scheduleTableView)

        setupInitalConstraints()
    }

    private func setupInitalConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            scrollContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            nextRaceTitleLabel.topAnchor.constraint(equalTo: scrollContainerView.safeAreaLayoutGuide.topAnchor, constant: 16),
            nextRaceTitleLabel.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            nextRaceTitleLabel.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),

            currentRaceCard.topAnchor.constraint(equalTo: nextRaceTitleLabel.bottomAnchor, constant: 16),
            currentRaceCard.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            currentRaceCard.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),
            
            separator.topAnchor.constraint(equalTo: currentRaceCard.bottomAnchor, constant: 16),
            separator.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),
            separator.heightAnchor.constraint(equalToConstant: 1),

            noScheduleLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 16),
            noScheduleLabel.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            noScheduleLabel.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),

            scheduleTitleLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 16),
            scheduleTitleLabel.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            scheduleTitleLabel.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),
            
            scheduleTableView.topAnchor.constraint(equalTo: scheduleTitleLabel.bottomAnchor),
            scheduleTableView.leftAnchor.constraint(equalTo: scrollContainerView.leftAnchor),
            scheduleTableView.rightAnchor.constraint(equalTo: scrollContainerView.rightAnchor),
            scheduleTableView.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor)
        ])
    }

    // MARK: - UI Elements
    private static func createLabel(fontSize: Int, color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: CGFloat(fontSize))
        label.textColor = color
        return label
    }

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()

    private let scrollContainerView: UIView = {
        let scrollContainerView = UIView()
        scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
        return scrollContainerView
    }()
    
    private let nextRaceTitleLabel: UILabel = {
        let label = createLabel(fontSize: 24, color: .black)
        label.text = "Следующая гонка"
        return label
    }()
    
    private let scheduleTitleLabel: UILabel = {
        let label = createLabel(fontSize: 24, color: .black)
        label.text = "Полное расписание"
        return label
    }()

    private let currentRaceCard: RaceCardView = {
        let view = RaceCardView()
        return view
    }()

    private let scheduleTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        
        tableView.rowHeight = CGFloat(ScheduleTableViewDelegate.rowHeight)
        tableView.separatorStyle = .none
        
        return tableView
    }()

    private let noScheduleLabel: UILabel = {
        let label = createLabel(fontSize: 16, color: .lightGray)
        label.text = "Полного расписания пока нет"
        label.textAlignment = .center
        return label
    }()
    
    private let separator = Separator()

    // MARK: - Data Methods
    public func loadedCurrentRace(race: ChampionshipRace?) {
        if race != nil {
            currentRaceCard.configure(race: race!)
        }
    }

    public func loadedAllRaces(races: [ChampionshipRace?]) {
        noScheduleLabel.isHidden = true
        scheduleTableView.isHidden = false
        
        scheduleTableViewDelegate = ScheduleTableViewDelegate(items: races)
        scheduleTableViewDelegate?.selectionDelegate = self

        scheduleTableView.delegate = scheduleTableViewDelegate
        scheduleTableView.dataSource = scheduleTableViewDelegate
        scheduleTableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.scheduleTableViewCell.rawValue)
        
        scheduleTableView.layoutIfNeeded()
        scheduleTableView.heightAnchor.constraint(equalToConstant: scheduleTableView.contentSize.height).isActive = true
    }
}

extension ScheduleViewController: UITableViewSelectionDelegate {
    func didSelectItem(at index: Int) {
        print("fuck")
    }
}

// MARK: - Preview
 @available(iOS 17, *)
 #Preview {
    let factory = FactoryMock()
    let view = factory.makeScheduleViewController()
    return view
 }
