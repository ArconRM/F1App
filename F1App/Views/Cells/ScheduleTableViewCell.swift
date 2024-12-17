//
//  ScheduleTableViewCell.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 17.12.2024.
//


import UIKit

class ScheduleTableViewCell: UITableViewCell {

    let titleLabel = createLabel(fontSize: 18, color: .black)
    let curcuitLabel = createLabel(fontSize: 14, color: .darkGray)
    let dateLabel = createLabel(fontSize: 16, color: .black)
    let winnerLabel = createLabel(fontSize: 14, color: .black)
    
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
            
            titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            
            curcuitLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            curcuitLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            curcuitLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: curcuitLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8),
//            
            winnerLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            winnerLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            winnerLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8)
        ])
    }
    
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
}
