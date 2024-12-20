//
//  ScheduleTableViewCell.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 17.12.2024.
//


import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
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
        contentView.addSubview(mainStackView)
        
        mainStackView.addSubview(numberLabel)
        mainStackView.addSubview(separator)
        mainStackView.addSubview(labelsStackView)
        
        labelsStackView.addSubview(titleLabel)
        labelsStackView.addSubview(curcuitLabel)
        labelsStackView.addSubview(dateLabel)
        labelsStackView.addSubview(winnerLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            numberLabel.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 16),
            numberLabel.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor),
            numberLabel.widthAnchor.constraint(equalToConstant: 30),
            
            separator.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            separator.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 8),
            separator.widthAnchor.constraint(equalToConstant: 1),
            
            labelsStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: separator.leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: labelsStackView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: labelsStackView.trailingAnchor, constant: -16),
            
            curcuitLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            curcuitLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 32),
            curcuitLabel.trailingAnchor.constraint(equalTo: labelsStackView.trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: curcuitLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 32),
            dateLabel.trailingAnchor.constraint(equalTo: labelsStackView.trailingAnchor, constant: -8),
            
            winnerLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            winnerLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 32),
            winnerLabel.trailingAnchor.constraint(equalTo: labelsStackView.trailingAnchor, constant: -8)
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
    
    private static func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = .fill
//        stackView.distribution = axis == .vertical ? .fillEqually : .fill
        
        return stackView
    }
    
    public let mainStackView: UIStackView = createStackView(axis: .horizontal)
    public let labelsStackView: UIStackView = createStackView(axis: .vertical)
    
    private let separator = Separator()
    
    private let numberLabel = createLabel(fontSize: 16, color: .appColor(.mainTextColor))
    private let titleLabel = createLabel(fontSize: 18, color: .appColor(.mainTextColor))
    private let curcuitLabel = createLabel(fontSize: 14, color: .appColor(.subTextColor))
    private let dateLabel = createLabel(fontSize: 16, color: .appColor(.mainTextColor))
    private let winnerLabel = createLabel(fontSize: 14, color: .appColor(.mainTextColor))
    
    // MARK: - Public Methods
    public func configure(item: ChampionshipRace) {
        numberLabel.text = "\(item.round)"
        
        titleLabel.text = item.raceName
        curcuitLabel.text = item.circuitName
        
        if let fp1Datetime = item.fp1Datetime, let raceDatetime = item.raceDatetime {
            dateLabel.text = "\(fp1Datetime.getDayMonthString()) - \(raceDatetime.getDayMonthString())"
        } else {
            dateLabel.text = "Нет даты"
        }
        
        if let winnerName = item.winnerName {
            winnerLabel.text = "Победитель: \(winnerName)"
            labelsStackView.layer.opacity = 0.5
        } else {
            winnerLabel.removeFromSuperview()
        }
    }
}
