//
//  RaceCardView.swift
//  F1App
//
//  Created by Artemiy MIROTVORTSEV on 08.12.2024.
//

import UIKit

class RaceCardView: UIView {
    
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
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        addSubview(titleLabel)
        addSubview(curcuitLabel)
        addSubview(separator)
        addSubview(noScheduleLabel)
        
        setupInitalConstraints()
    }
    
    private func setupInitalConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            curcuitLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            curcuitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            curcuitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            separator.topAnchor.constraint(equalTo: curcuitLabel.bottomAnchor, constant: 8),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            noScheduleLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8),
            noScheduleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            noScheduleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            noScheduleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
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
    
    private static func createStackView(with text: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        
        let staticLabel = createLabel(fontSize: 14, color: .black)
        staticLabel.text = text
        
        let dateLabel = createLabel(fontSize: 14, color: .darkGray)
        dateLabel.text = "-"
        
        stackView.addArrangedSubview(staticLabel)
        stackView.addArrangedSubview(dateLabel)
        
        return stackView
    }
    
    private let titleLabel: UILabel = {
        let label = createLabel(fontSize: 18, color: .black)
        label.text = "Нет данных о названии"
        return label
    }()
    
    private let curcuitLabel: UILabel = {
        let label = createLabel(fontSize: 14, color: .darkGray)
        label.text = "Нет данных о трассе"
        return label
    }()
    
    private let separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .lightGray
        return separator
    }()
    
    private let noScheduleLabel: UILabel = {
        let label = createLabel(fontSize: 14, color: .darkGray)
        label.text = "Нет расписания"
        label.textAlignment = .center
        return label
    }()
    
    private let fp1DateStackView = createStackView(with: "Практика 1:")
    private let fp2DateStackView = createStackView(with: "Практика 2:")
    private let fp3DateStackView = createStackView(with: "Практика 3:")
    private let qualyDateStackView = createStackView(with: "Квалификация:")
    private let raceDateStackView = createStackView(with: "Гонка:")
    
    // MARK: - Configuration Method
    func configure(race: ChampionshipRace) {
        noScheduleLabel.removeFromSuperview()
        
        titleLabel.text = race.raceName
        curcuitLabel.text = race.circuitName
        
        if let fp1Label = fp1DateStackView.arrangedSubviews[1] as? UILabel {
            fp1Label.text = race.fp1Datetime?.getDayMonthTimeWordString() ?? "-"
        }
        
        if let fp2Label = fp2DateStackView.arrangedSubviews[1] as? UILabel {
            fp2Label.text = race.fp2Datetime?.getDayMonthTimeWordString() ?? "-"
        }
        
        if let fp3Label = fp3DateStackView.arrangedSubviews[1] as? UILabel {
            fp3Label.text = race.fp3Datetime?.getDayMonthTimeWordString() ?? "-"
        }
        
        if let qualyLabel = qualyDateStackView.arrangedSubviews[1] as? UILabel {
            qualyLabel.text = race.qualyDatetime?.getDayMonthTimeWordString() ?? "-"
        }
        
        if let raceLabel = raceDateStackView.arrangedSubviews[1] as? UILabel {
            raceLabel.text = race.raceDatetime?.getDayMonthTimeWordString() ?? "-"
        }
        
        addSubview(fp1DateStackView)
        addSubview(fp2DateStackView)
        addSubview(fp3DateStackView)
        addSubview(qualyDateStackView)
        addSubview(raceDateStackView)
        
        setupScheduleConstraints()
    }
    
    func setupScheduleConstraints() {
        NSLayoutConstraint.activate([
            fp1DateStackView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8),
            fp1DateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fp1DateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            fp2DateStackView.topAnchor.constraint(equalTo: fp1DateStackView.bottomAnchor, constant: 8),
            fp2DateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fp2DateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            fp3DateStackView.topAnchor.constraint(equalTo: fp2DateStackView.bottomAnchor, constant: 8),
            fp3DateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fp3DateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            qualyDateStackView.topAnchor.constraint(equalTo: fp3DateStackView.bottomAnchor, constant: 8),
            qualyDateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            qualyDateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            raceDateStackView.topAnchor.constraint(equalTo: qualyDateStackView.bottomAnchor, constant: 8),
            raceDateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            raceDateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            raceDateStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

@available(iOS 17, *)
#Preview {
    let view = RaceCardView()
    view.configure(race: ChampionshipRace.mock)
    return view
}