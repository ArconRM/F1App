//
//  QualyResultCardView.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 01.01.2025.
//

import Foundation
import UIKit

class QualyResultCardView: UIView {

    private var q1ResultsVStackBottomAnchor: NSLayoutConstraint?
    private var q2ResultsVStackBottomAnchor: NSLayoutConstraint?
    private var q3ResultsVStackBottomAnchor: NSLayoutConstraint?

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup View
    private func setupView() {
        backgroundColor = .appColor(.viewsBackgroundColor)
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 10

        addSubview(headerLabel)
        addSubview(separator)
        addSubview(segmentedControl)
        addSubview(q1ResultsVStack)
        addSubview(q2ResultsVStack)
        addSubview(q3ResultsVStack)

        q1ResultsVStack.isHidden = true
        q2ResultsVStack.isHidden = true

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            separator.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separator.heightAnchor.constraint(equalToConstant: 0.4),

            segmentedControl.topAnchor.constraint(equalTo: separator.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),

            q1ResultsVStack.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            q1ResultsVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            q1ResultsVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            q2ResultsVStack.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            q2ResultsVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            q2ResultsVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            q3ResultsVStack.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            q3ResultsVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            q3ResultsVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        q1ResultsVStackBottomAnchor = q1ResultsVStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        q2ResultsVStackBottomAnchor = q2ResultsVStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        q3ResultsVStackBottomAnchor = q3ResultsVStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)

        q3ResultsVStackBottomAnchor?.isActive = true
    }

    // MARK: - UI Elements
    private let headerLabel = LabelFactory.createLabel(fontSize: FontSizes.header.rawValue, color: .appColor(.mainTextColor))
    private let separator = Separator()
    private let q1ResultsVStack = StackViewFactory.createStackView(axis: .vertical, spacing: 8)
    private let q2ResultsVStack = StackViewFactory.createStackView(axis: .vertical, spacing: 8)
    private let q3ResultsVStack = StackViewFactory.createStackView(axis: .vertical, spacing: 8)

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Q1", "Q2", "Q3"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 2
        control.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        return control
    }()

    @objc private func segmentChanged() {
        q1ResultsVStack.isHidden = true
        q2ResultsVStack.isHidden = true
        q3ResultsVStack.isHidden = true

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            q1ResultsVStack.isHidden = false
            adjustBottomAnchor(qualyNumber: 1)
        case 1:
            q2ResultsVStack.isHidden = false
            adjustBottomAnchor(qualyNumber: 2)
        case 2:
            q3ResultsVStack.isHidden = false
            adjustBottomAnchor(qualyNumber: 3)
        default:
            break
        }
    }

    private func adjustBottomAnchor(qualyNumber: Int) {
        self.q1ResultsVStackBottomAnchor?.isActive = false
        self.q2ResultsVStackBottomAnchor?.isActive = false
        self.q3ResultsVStackBottomAnchor?.isActive = false

        switch qualyNumber {
        case 1:
            self.q1ResultsVStackBottomAnchor?.isActive = true
        case 2:
            self.q2ResultsVStackBottomAnchor?.isActive = true
        case 3:
            self.q3ResultsVStackBottomAnchor?.isActive = true
        default:
            break
        }
    }

    // MARK: - Data Methods
    func configure(isSprint: Bool, qualyResults: [QualyDriverResult]) {
        headerLabel.text = "Квалификация\(isSprint ? " (спринт)" : "")"

        for (index, driverQ1Result) in qualyResults.sorted(by: {
            guard let time1 = $0.q1Time, let time2 = $1.q1Time else {
                return $0.q1Time != nil
            }
            return time1 < time2
        }).enumerated() {
            q1ResultsVStack.addArrangedSubview(setupResultsHStackView(qualyNumber: 1, position: index + 1, qualyDriverResult: driverQ1Result))
        }

        for (index, driverQ2Result) in qualyResults.filter( { $0.q2Time != nil }).sorted(by: { $0.q2Time! < $1.q2Time! }).enumerated() {
            q2ResultsVStack.addArrangedSubview(setupResultsHStackView(qualyNumber: 2, position: index + 1, qualyDriverResult: driverQ2Result))
        }

        for driverQ3Result in qualyResults.filter( { $0.q3Time != nil }).sorted(by: { $0.q3Time! < $1.q3Time! }) {
            q3ResultsVStack.addArrangedSubview(setupResultsHStackView(qualyNumber: 3, position: driverQ3Result.position, qualyDriverResult: driverQ3Result))
        }
    }

    private func setupResultsHStackView(qualyNumber: Int, position: Int, qualyDriverResult: QualyDriverResult) -> UIStackView {
        let hStack = StackViewFactory.createStackView(axis: .horizontal)

        let positionLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
        positionLabel.text = "\(position)"
        positionLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true

        let driverLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor), multiline: false)
        driverLabel.text = qualyDriverResult.driver.fullName

        let timeLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
        timeLabel.text = {
            switch qualyNumber {
            case 1:
                return qualyDriverResult.q1Time
            case 2:
                return qualyDriverResult.q2Time
            case 3:
                return qualyDriverResult.q3Time
            default:
                return "-"
            }
        }()
        timeLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        timeLabel.textAlignment = .right

        hStack.addArrangedSubview(positionLabel)
        hStack.addArrangedSubview(driverLabel)
        hStack.addArrangedSubview(timeLabel)

        return hStack
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let cardView = QualyResultCardView()
    cardView.configure(isSprint: false, qualyResults: QualyDriverResult.mockArray)

    let backgroundView = UIView()
    backgroundView.backgroundColor = .appColor(.backgroundPrimaryColor)
    backgroundView.addSubview(cardView)

    cardView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    cardView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true

    return backgroundView
}
