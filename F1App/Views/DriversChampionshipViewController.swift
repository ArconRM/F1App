//
//  DriversChampionshipViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.12.2024.
//

import Foundation
import UIKit

class DriversChampionshipViewController: BaseViewController {

    private var championshipTableViewDelegate: DriversChampionshipTableViewDelegate?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        championshipTableViewDelegate = DriversChampionshipTableViewDelegate()
        championshipTableViewDelegate?.selectionDelegate = self

        championshipTableView.delegate = championshipTableViewDelegate
        championshipTableView.dataSource = championshipTableViewDelegate
        championshipTableView.register(DriversChampionshipTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.driversChampionshipTableViewCell.rawValue)

        setupView()
        presenter.viewDidLoad()
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

        backgroundGradientView.frame = view.bounds

        view.addSubview(backgroundGradientView)
        view.addSubview(titleLabel)
        view.addSubview(scrollView)

        scrollView.addSubview(scrollContainerView)

        scrollContainerView.addSubview(championshipTableView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            scrollContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            championshipTableView.topAnchor.constraint(equalTo: scrollContainerView.topAnchor),
            championshipTableView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 16),
            championshipTableView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -16),
            championshipTableView.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - UI Elements
    private let backgroundGradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.colors = UIColor.appGradientColors(.mainGradientColors)
        gradientView.opacity = 0.3
        return gradientView
    }()

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
        label.text = "Личный зачет"
        return label
    }()

    private let championshipTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false

        tableView.estimatedRowHeight = DriversChampionshipTableViewDelegate.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.separatorColor = .gray

        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .appColor(.viewsBackgroundColor)

        return tableView
    }()

    // MARK: - Data Methods
    func loadedDriversChampionship(_ driversChampionship: [DriversChampionshipEntry?]) {
        championshipTableViewDelegate?.setItems(items: driversChampionship)

        championshipTableView.reloadData()
        championshipTableView.layoutIfNeeded()
        championshipTableView.heightAnchor.constraint(equalToConstant: championshipTableView.contentSize.height).isActive = true
    }
}

// MARK: - Extensions
extension DriversChampionshipViewController: UITableViewSelectionDelegate {
    func didSelectItem(at index: Int) {
        print("fuck")
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let factory = DependencyFactoryMock()
    let view = factory.makeDriversChampionshipViewController()
    return view
}
