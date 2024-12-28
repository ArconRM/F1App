//
//  ScheduleTableViewCell.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 17.12.2024.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    static let cellHeightFull: CGFloat = 150
    static let cellHeightWithoutWinner: CGFloat = 120

    // Для отступов по бокам
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame = frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
            super.frame = frame
        }
    }

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup View
    private func setupViews() {
        contentView.addSubview(mainHStackView)

        mainHStackView.addSubview(numberLabel)
        mainHStackView.addSubview(separator)
        mainHStackView.addSubview(labelsVStackView)

        labelsVStackView.addSubview(titleLabel)
        labelsVStackView.addSubview(curcuitLabel)
        labelsVStackView.addSubview(dateLabel)
        labelsVStackView.addSubview(winnerLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainHStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainHStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainHStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainHStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            numberLabel.topAnchor.constraint(equalTo: mainHStackView.topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: mainHStackView.leadingAnchor, constant: 12),
            numberLabel.centerYAnchor.constraint(equalTo: mainHStackView.centerYAnchor),
            numberLabel.widthAnchor.constraint(equalToConstant: 25),

            separator.topAnchor.constraint(equalTo: mainHStackView.topAnchor, constant: 8),
            separator.bottomAnchor.constraint(equalTo: mainHStackView.bottomAnchor, constant: 8),
            separator.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 8),
            separator.widthAnchor.constraint(equalToConstant: 0.5),
            separator.heightAnchor.constraint(equalTo: mainHStackView.heightAnchor, constant: -16),

            labelsVStackView.topAnchor.constraint(equalTo: mainHStackView.topAnchor),
            labelsVStackView.bottomAnchor.constraint(equalTo: mainHStackView.bottomAnchor),
            labelsVStackView.leadingAnchor.constraint(equalTo: separator.leadingAnchor),
            labelsVStackView.trailingAnchor.constraint(equalTo: mainHStackView.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: labelsVStackView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: labelsVStackView.trailingAnchor, constant: -16),

            curcuitLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            curcuitLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 20),
            curcuitLabel.trailingAnchor.constraint(equalTo: labelsVStackView.trailingAnchor, constant: -8),

            dateLabel.topAnchor.constraint(equalTo: curcuitLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: labelsVStackView.trailingAnchor, constant: -8),

            winnerLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            winnerLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 20),
            winnerLabel.trailingAnchor.constraint(equalTo: labelsVStackView.trailingAnchor, constant: -8)
        ])
    }

    // MARK: - UI Elements
    let mainHStackView: UIStackView = StackViewFactory.createStackView(axis: .horizontal)
    let labelsVStackView: UIStackView = StackViewFactory.createStackView(axis: .vertical)

    private let separator = Separator()

    private let numberLabel = LabelFactory.createLabel(fontSize: 16, color: .appColor(.mainTextColor))
    private let titleLabel = LabelFactory.createLabel(fontSize: 18, color: .appColor(.mainTextColor))
    private let curcuitLabel = LabelFactory.createLabel(fontSize: 14, color: .appColor(.subTextColor))
    private let dateLabel = LabelFactory.createLabel(fontSize: 16, color: .appColor(.mainTextColor))
    private let winnerLabel = LabelFactory.createLabel(fontSize: 14, color: .appColor(.mainTextColor))

    // MARK: - Data Methods
    func configure(item: Round) {
        numberLabel.text = "\(item.round)"

        titleLabel.text = item.raceName
        curcuitLabel.text = item.circuit?.name

        if let fp1Datetime = item.fp1Datetime, let raceDatetime = item.raceDatetime {
            dateLabel.text = "\(fp1Datetime.getDayMonthString()) - \(raceDatetime.getDayMonthString())"
        } else {
            dateLabel.text = "Нет даты"
        }

        if let winnerName = item.winner?.name {
            winnerLabel.text = "Победитель: \(winnerName)"
            labelsVStackView.layer.opacity = 0.5
        } else {
            winnerLabel.removeFromSuperview()
        }
    }
}
