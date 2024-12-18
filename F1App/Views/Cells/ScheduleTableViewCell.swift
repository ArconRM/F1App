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
            frame.origin.x += 16
            frame.size.width -= 32
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
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4

        contentView.addSubview(stackView)
        
        stackView.addSubview(numberLabel)
        stackView.addSubview(titleLabel)
        stackView.addSubview(curcuitLabel)
        stackView.addSubview(dateLabel)
        stackView.addSubview(winnerLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            numberLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 16),
            numberLabel.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            numberLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            curcuitLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            curcuitLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 16),
            curcuitLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: curcuitLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8),
            
            winnerLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            winnerLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 16),
            winnerLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8)
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let numberLabel = createLabel(fontSize: 16, color: .black)
    private let titleLabel = createLabel(fontSize: 18, color: .black)
    private let curcuitLabel = createLabel(fontSize: 14, color: .darkGray)
    private let dateLabel = createLabel(fontSize: 16, color: .black)
    private let winnerLabel = createLabel(fontSize: 14, color: .black)
    
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
            stackView.layer.opacity = 0.5
        } else {
            winnerLabel.removeFromSuperview()
        }
    }
}
