//
//  ConstructorsChampionshipViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 06.12.2024.
//

import Foundation
import UIKit

final class ConstructorsChampionshipViewController: BaseViewController<ConstructorsChampionshipPresenter>, ConstructorsChampionshipPresentable {

    var coordinator: ConstructorsChampionshipViewCoordinator?

    private var championshipTableViewDelegate: ConstructorsChampionshipTableViewDelegate?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        championshipTableViewDelegate = ConstructorsChampionshipTableViewDelegate()
        championshipTableViewDelegate?.selectionDelegate = self

        championshipTableView.delegate = championshipTableViewDelegate
        championshipTableView.dataSource = championshipTableViewDelegate
        championshipTableView.register(ConstructorsChampionshipTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.constructorsChampionshipTableViewCell.rawValue)

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
        navigationController?.navigationBar.isHidden = true
        
        championshipTableView.isHidden = true

        view.addSubview(backgroundGradientView)
        view.addSubview(titleLabel)
        view.addSubview(segmentedControl)
        view.addSubview(scrollView)

        scrollView.addSubview(scrollContainerView)

        scrollContainerView.addSubview(championshipTableView)
        scrollContainerView.addSubview(loadingLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundGradientView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundGradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),

            scrollView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            loadingLabel.topAnchor.constraint(equalTo: scrollContainerView.topAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            loadingLabel.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),

            championshipTableView.topAnchor.constraint(equalTo: scrollContainerView.topAnchor),
            championshipTableView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            championshipTableView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),
            championshipTableView.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor, constant: -16)
        ])
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
        let segmentItems = Constants.availableSeasons
        let segmentedControl = UISegmentedControl(items: segmentItems)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        return segmentedControl
    }()

    @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
        let year = Int(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "")
        loadingLabel.isHidden = false
        championshipTableView.isHidden = true
        presenter.handleSeasonSelectionChange(year: year)
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

    private let titleLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: FontSizes.title.rawValue, color: .appColor(.mainTextColor))
        label.text = "Командный зачет"
        return label
    }()

    private let loadingLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.subTextColor))
        label.text = "Загрузка..."
        label.textAlignment = .center
        return label
    }()

    private let championshipTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false

        tableView.estimatedRowHeight = ConstructorsChampionshipTableViewDelegate.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.separatorColor = .gray

        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .appColor(.viewsBackgroundColor)

        return tableView
    }()

    // MARK: - Data Methods
    func loadedConstructorsChampionship(_ constructorsChampionship: [ConstructorsChampionshipEntry?]) {
        loadingLabel.isHidden = true
        championshipTableView.isHidden = false

        championshipTableViewDelegate?.setItems(items: constructorsChampionship)

        DispatchQueue.main.async {
            self.championshipTableView.reloadData()
            self.championshipTableView.layoutIfNeeded()
            self.championshipTableView.heightAnchor.constraint(equalToConstant: self.championshipTableView.contentSize.height).isActive = true
        }
    }
}

// MARK: - Extensions
extension ConstructorsChampionshipViewController: UITableViewSelectionDelegate {
    func didSelectItem(at index: Int) {
        if let item = championshipTableViewDelegate?.items[index] {
            coordinator?.showTeamDetails(team: item.team)
        }
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let factory = DependencyFactoryWithMockData()
    let view = factory.makeConstructorChampionshipViewController()
    return view
}
