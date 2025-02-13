//
//  ScheduleViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.12.2024.
//

import Foundation
import UIKit

final class ScheduleViewController: BaseViewController<SchedulePresenter>, SchedulePresentable {

    var coordinator: ScheduleViewCoordinator?

    private var scheduleTableViewDelegate: ScheduleTableViewDelegate?
    
    private var tableViewHeightAnchor: NSLayoutConstraint?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        scheduleTableViewDelegate = ScheduleTableViewDelegate()
        scheduleTableViewDelegate?.selectionDelegate = self

        scheduleTableView.delegate = scheduleTableViewDelegate
        scheduleTableView.dataSource = scheduleTableViewDelegate
        scheduleTableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.scheduleTableViewCell.rawValue)

        setupView()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.isHidden = false
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection!) {
            backgroundGradientView.colors = UIColor.appGradientColors(.mainGradientColors)
        }
    }

    // MARK: - Setup View
    private func setupView() {
        view.backgroundColor = .adaptiveColor(light: .white, dark: .black)

        scheduleTableView.isHidden = true

        view.addSubview(backgroundGradientView)
        view.addSubview(scrollView)

        scrollView.addSubview(scrollContainerView)

        scrollContainerView.addSubview(nextRaceTitleLabel)
        scrollContainerView.addSubview(currentRaceCard)
        scrollContainerView.addSubview(separator)
        scrollContainerView.addSubview(segmentedControl)
        scrollContainerView.addSubview(loadingLabel)
        scrollContainerView.addSubview(scheduleTitleLabel)
        scrollContainerView.addSubview(scheduleTableView)

        setupInitalConstraints()
    }

    private func setupInitalConstraints() {
        NSLayoutConstraint.activate([
            backgroundGradientView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundGradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            scrollContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            nextRaceTitleLabel.topAnchor.constraint(equalTo: scrollContainerView.safeAreaLayoutGuide.topAnchor, constant: 16),
            nextRaceTitleLabel.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            nextRaceTitleLabel.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor),

            currentRaceCard.topAnchor.constraint(equalTo: nextRaceTitleLabel.bottomAnchor, constant: 16),
            currentRaceCard.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            currentRaceCard.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),

            separator.topAnchor.constraint(equalTo: currentRaceCard.bottomAnchor, constant: 16),
            separator.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            segmentedControl.topAnchor.constraint(equalTo: separator.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),

            scheduleTitleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            scheduleTitleLabel.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            scheduleTitleLabel.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor),

            loadingLabel.topAnchor.constraint(equalTo: scheduleTitleLabel.bottomAnchor, constant: 16),
            loadingLabel.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            loadingLabel.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),

            scheduleTableView.topAnchor.constraint(equalTo: scheduleTitleLabel.bottomAnchor),
            scheduleTableView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor),
            scheduleTableView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor),
            scheduleTableView.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor)
        ])
        
        tableViewHeightAnchor = scheduleTableView.heightAnchor.constraint(equalToConstant: scheduleTableView.contentSize.height)
        tableViewHeightAnchor?.isActive = true
    }

    // MARK: - UI Elements
    private let backgroundGradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.colors = UIColor.appGradientColors(.mainGradientColors)
        gradientView.opacity = 0.3
        return gradientView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let now = Date()
        let segmentItems = ["\(now.getYear())", "\(now.getYear() - 1)"]
        let segmentedControl = UISegmentedControl(items: segmentItems)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    @objc private func segmentValueChanged(_ sender : UISegmentedControl) {
        loadingLabel.isHidden = false
        scheduleTableView.isHidden = true
        presenter.handleSeasonSelectionChange(selectionIndex: sender.selectedSegmentIndex)
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
        let label = LabelFactory.createLabel(fontSize: FontSizes.title.rawValue, color: .appColor(.mainTextColor))
        label.text = "Следующий этап"
        return label
    }()

    private let scheduleTitleLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: FontSizes.title.rawValue, color: .appColor(.mainTextColor))
        label.text = "Полное расписание"
        return label
    }()

    private let currentRaceCard: RaceScheduleCardView = {
        let view = RaceScheduleCardView()
        return view
    }()

    private let scheduleTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false

        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderTopPadding = 10

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear

        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero

        return tableView
    }()

    private let loadingLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.subTextColor))
        label.text = "Загрузка..."
        label.textAlignment = .center
        return label
    }()

    private let separator = Separator()

    // MARK: - Data Methods
    func loadedNextRace(_ round: Round?) {
        if round != nil {
            currentRaceCard.configure(round: round!)
        }
    }

    func loadedCurrentSeasonRaces(_ races: [Round?]) {
        if races.isEmpty {
            loadingLabel.text = "Полного расписания пока нет"
        } else {
            loadingLabel.isHidden = true
            scheduleTableView.isHidden = false
            
            updateTableView(with: races)
        }
    }
    
    func loadedPrevSeasonRaces(_ races: [Round?]) {
        if races.isEmpty {
            loadingLabel.text = "Полного расписания пока нет"
        } else {
            loadingLabel.isHidden = true
            scheduleTableView.isHidden = false
            
            updateTableView(with: races)
        }
    }
    
    private func updateTableView(with data: [Round?]) {
        DispatchQueue.main.async {
            self.scheduleTableViewDelegate?.setItems(items: data)
            self.scheduleTableView.reloadData()
            
            self.scheduleTableView.layoutIfNeeded()
            self.tableViewHeightAnchor?.constant = self.scheduleTableView.contentSize.height
        }
    }
}

// MARK: - Extensions
extension ScheduleViewController: UITableViewSelectionDelegate {
    func didSelectItem(at index: Int) {
        if let item = scheduleTableViewDelegate?.items[index] {
            coordinator?.showRoundDetails(round: item)
        }
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let factory = DependencyFactoryWithMockData()
    let view = factory.makeScheduleViewController()
    return view
}
