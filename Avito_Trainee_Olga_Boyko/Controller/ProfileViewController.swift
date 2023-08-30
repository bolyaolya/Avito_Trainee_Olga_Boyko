//
//  ProfileViewController.swift
//  Avito_Trainee_Olga_Boyko
//
//  Created by Ольга Бойко on 25.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Страница профиля"
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 25, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    //MARK: - Methods
}
