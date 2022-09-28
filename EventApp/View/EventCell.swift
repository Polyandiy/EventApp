//
//  EventCell.swift
//  EventApp
//
//  Created by Поляндий on 27.09.2022.
//

import Foundation
import UIKit

final class EventCell: UITableViewCell {
    
    private let timeRemainigLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    
    private let dateLabel = UILabel()
    private let eventNameLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private let verticalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        (timeRemainigLabels + [eventNameLabel, backgroundImageView, verticalStackView]).forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        timeRemainigLabels.forEach {
            $0.font = .systemFont(ofSize: 28, weight: .medium)
            $0.textColor = .white
        }
        dateLabel.font = .systemFont(ofSize: 22, weight: .medium)
        dateLabel.textColor = .white
        eventNameLabel.font = .systemFont(ofSize: 34, weight: .bold)
        eventNameLabel.textColor = .white
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
//        backgroundImageView.contentMode = .scaleToFill
    }
    
    private func setupHierarchy() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(eventNameLabel)
        timeRemainigLabels.forEach {
            verticalStackView.addArrangedSubview($0)
        }
        verticalStackView.addArrangedSubview(UIView())
        verticalStackView.addArrangedSubview(dateLabel)
    }
    
    private func setupLayout() {
        backgroundImageView.pinToSuperviewEdges([.left,.right,.top])
        let bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required  - 1
        bottomConstraint.isActive = true
        
        backgroundImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        verticalStackView.pinToSuperviewEdges([.top, .right, .bottom], constant: 15)
        eventNameLabel.pinToSuperviewEdges([.left, .bottom], constant: 15)
    }
    
    func update(with viewModel: EventCellViewModel) {
        viewModel.timeReainingString.enumerated().forEach {
            timeRemainigLabels[$0.offset].text = $0.element
        }
        dateLabel.text = viewModel.dateText
        eventNameLabel.text = viewModel.eventName
        
        viewModel.loadImage { image in
            self.backgroundImageView.image = image
        }
    }
}
