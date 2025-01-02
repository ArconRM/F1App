//
//  ScheduleTableViewCell.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 17.12.2024.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    private var dateLabelBottomConstraint: NSLayoutConstraint?

    // MARK: - Life Cycle
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

    override func layoutSubviews() {
        super.layoutSubviews()

        let maskPath = UIBezierPath(
            roundedRect: CGRect(origin: .zero, size: self.bounds.size),
            byRoundingCorners: [.topLeft, .topRight, .bottomRight, .bottomLeft],
            cornerRadii: CGSize(width: 10, height: 10)
        )

        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = maskPath.cgPath
        self.layer.mask = shapeLayer
    }

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup View
    private func setupView() {
        contentView.backgroundColor = .appColor(.viewsBackgroundColor)

        contentView.addSubview(numberLabel)
        contentView.addSubview(separator)
        contentView.addSubview(headerLabel)
        contentView.addSubview(curcuitLabel)
        contentView.addSubview(dateLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberLabel.widthAnchor.constraint(equalToConstant: 25),

            separator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            separator.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 8),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            separator.widthAnchor.constraint(equalToConstant: 0.3),
            separator.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -16),

            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            headerLabel.leadingAnchor.constraint(equalTo: separator.trailingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            curcuitLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
            curcuitLabel.leadingAnchor.constraint(equalTo: separator.trailingAnchor, constant: 16),
            curcuitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            curcuitLabel.heightAnchor.constraint(equalToConstant: 24),

            dateLabel.topAnchor.constraint(equalTo: curcuitLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: separator.trailingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        dateLabelBottomConstraint = dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        dateLabelBottomConstraint?.isActive = true
    }

    // MARK: - UI Elements
    private let separator = Separator()

    private let numberLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
    private let headerLabel = LabelFactory.createLabel(fontSize: FontSizes.header.rawValue, color: .appColor(.mainTextColor))
    private let curcuitLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.subTextColor))
    private let dateLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))
    private let winnerLabel = LabelFactory.createLabel(fontSize: FontSizes.body.rawValue, color: .appColor(.mainTextColor))

    // MARK: - Data Methods
    func configure(item: Round) {
        numberLabel.text = "\(item.round)"

        headerLabel.text = item.raceName
        curcuitLabel.text = item.circuit?.name

        if let fp1Datetime = item.fp1Datetime, let raceDatetime = item.raceDatetime {
            dateLabel.text = "\(fp1Datetime.getDayMonthString()) - \(raceDatetime.getDayMonthString())"
        } else {
            dateLabel.text = "Нет даты"
        }

        if item.winner != nil && item.teamWinner != nil {
            winnerLabel.text = "Победитель: \(item.winner!.fullName) (\(item.teamWinner!.teamName))"
            addWinnerLabel()

            numberLabel.layer.opacity = 0.5
            headerLabel.layer.opacity = 0.5
            curcuitLabel.layer.opacity = 0.5
            dateLabel.layer.opacity = 0.5
            winnerLabel.layer.opacity = 0.5
        }
    }

    func addWinnerLabel() {
        contentView.addSubview(winnerLabel)

        dateLabelBottomConstraint?.isActive = false

        NSLayoutConstraint.activate([
            winnerLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            winnerLabel.leadingAnchor.constraint(equalTo: separator.trailingAnchor, constant: 16),
            winnerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            winnerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            winnerLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
