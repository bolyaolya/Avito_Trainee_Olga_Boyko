//
//  ProductsCollectionViewCell.swift
//  Avito_Trainee_Olga_Boyko
//
//  Created by Ольга Бойко on 25.08.2023.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    lazy var contentViewCell: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var imageTask: URLSessionDataTask?
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 2
        title.lineBreakMode = .byTruncatingTail
        title.clipsToBounds = true
        title.textColor = .black
        title.font = .systemFont(ofSize: 18, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var price: UILabel = {
        let price = UILabel()
        price.numberOfLines = 1
        price.textColor = .black
        price.font = .systemFont(ofSize: 17, weight: .bold)
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    lazy var location: UILabel = {
        let location = UILabel()
        location.numberOfLines = 1
        location.textColor = .systemGray
        location.font = .systemFont(ofSize: 14, weight: .light)
        location.translatesAutoresizingMaskIntoConstraints = false
        return location
    }()
    
    lazy var date: UILabel = {
        let date = UILabel()
        date.numberOfLines = 1
        date.textColor = .systemGray
        date.font = .systemFont(ofSize: 14, weight: .light)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        image.image = nil
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        addSubview(contentViewCell)
        contentViewCell.addSubview(image)
        contentViewCell.addSubview(title)
        contentViewCell.addSubview(price)
        contentViewCell.addSubview(location)
        contentViewCell.addSubview(date)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentViewCell.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            contentViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            contentViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            contentViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.widthAnchor.constraint(equalToConstant: 175),
            image.heightAnchor.constraint(equalToConstant: 175),
            image.centerXAnchor.constraint(equalTo: contentViewCell.centerXAnchor),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            price.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            price.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            location.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 4),
            location.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            date.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 3),
            date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        ])
    }
    
    func configure(with item: Products) {
        title.text = item.title
        price.text = item.price
        location.text = item.location
        date.text = item.createdDate
        
        if let imageUrl = URL(string: item.imageUrl) {
            
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl),
                   let image = UIImage(data: imageData) {
                    
                    DispatchQueue.main.async {
                        self.image.image = image
                    }
                }
            }
        }
    }
}
