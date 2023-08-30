//
//  ErrorCollectionViewCell.swift.swift
//  Avito_Trainee_Olga_Boyko
//
//  Created by Ольга Бойко on 25.08.2023.
//

import UIKit

protocol ErrorCellDelegate: AnyObject {
    func retryButtonTapped()
}

final class ErrorCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    weak var delegate: ErrorCellDelegate?
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = .red
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Обновить ещё раз", for: .normal)
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        addSubview(errorLabel)
        addSubview(retryButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            retryButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            retryButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            errorLabel.bottomAnchor.constraint(equalTo: retryButton.topAnchor, constant: 16),
            errorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    @objc
    private func retryButtonTapped() {
        delegate?.retryButtonTapped()
    }
    
    func configure(with errorMessage : String) {
        errorLabel.text = errorMessage
    }
}
