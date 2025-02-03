//
//  DriversChampionshipViewController.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 02.12.2024.
//

import Foundation
import UIKit

final class DriversChampionshipViewController: BaseViewController<DriversChampionshipPresenter>, DriversChampionshipPresentable {

    var coordinator: DriversChampionshipViewCoordinator?

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
        view.addSubview(backgroundGradientView)
        view.addSubview(titleLabel)
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

            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
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

    private let loadingLabel: UILabel = {
        let label = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.subTextColor))
        label.text = "Загрузка..."
        label.textAlignment = .center
        return label
    }()

    // MARK: - Data Methods
    func loadedDriversChampionship(_ driversChampionship: [DriversChampionshipEntry?]) {
        loadingLabel.removeFromSuperview()

        championshipTableViewDelegate?.setItems(items: driversChampionship)

        DispatchQueue.main.async {
            self.championshipTableView.reloadData()
            self.championshipTableView.layoutIfNeeded()
            self.championshipTableView.heightAnchor.constraint(equalToConstant: self.championshipTableView.contentSize.height).isActive = true
        }
    }
}

// MARK: - Extensions
extension DriversChampionshipViewController: UITableViewSelectionDelegate {
    func didSelectItem(at index: Int) {
        if let item = championshipTableViewDelegate?.items[index] {
            coordinator?.showDriverDetails(driver: item.driver)
        }
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let factory = DependencyFactoryWithMockData()
    let view = factory.makeDriversChampionshipViewController()
    return view
}
