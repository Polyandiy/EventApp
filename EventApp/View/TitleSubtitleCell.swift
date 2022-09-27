//
//  TitleSubtitleCell.swift
//  EventApp
//
//  Created by Поляндий on 26.09.2022.
//


import Foundation
import UIKit

final class TitleSubtitleCell: UITableViewCell {
    private var viewModel: TitleSubtitleCellViewModel?
    private let titleLabel = UILabel()
    let subtitleTextField = UITextField()
    private let verticalStackView = UIStackView()
    private let conctant: CGFloat = 15
    
    private let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 100))
    private var dataPickerView: UIDatePicker = {
        let piker = UIDatePicker()
        piker.preferredDatePickerStyle = .wheels
        return piker
    }()
    lazy var doneButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }()
    
    private let photoImage = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placeholder
        subtitleTextField.inputView = viewModel.type == .text ? nil : dataPickerView
        subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolbar
        photoImage.isHidden = viewModel.type != .image
        subtitleTextField.isHidden = viewModel.type == .image
        verticalStackView.spacing = viewModel.type == .image ? 15 : verticalStackView.spacing
        photoImage.image = viewModel.image
    }
    
    private func setupViews() {
        verticalStackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subtitleTextField.font = .systemFont(ofSize: 20, weight: .medium)
        
        [verticalStackView, titleLabel, subtitleTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        toolbar.setItems([doneButton], animated: false)
        dataPickerView.datePickerMode = .date
        
        photoImage.backgroundColor = .black.withAlphaComponent(0.4)
        photoImage.layer.cornerRadius = 10
    }
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
        verticalStackView.addArrangedSubview(photoImage)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: conctant),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -conctant),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: conctant),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -conctant)
        ])
        photoImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc private func tappedDone() {
        viewModel?.update(dataPickerView.date)
    }
}

