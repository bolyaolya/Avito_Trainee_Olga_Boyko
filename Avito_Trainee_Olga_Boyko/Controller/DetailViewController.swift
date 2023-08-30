//
//  DetailViewController.swift
//  Avito_Trainee_Olga_Boyko
//
//  Created by Ольга Бойко on 25.08.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    enum State {
        case loading
        case error
        case content
    }
    
    var selectedProduct: Products?
    var itemId: String?
    lazy var stateofLoading: State = .loading
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var detailedImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var detailedTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 24, weight: .regular)
        return title
    }()
    
    private lazy var detailedPrice: UILabel = {
        let price = UILabel()
        price.font = .systemFont(ofSize: 24, weight: .bold)
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    private lazy var detailedLocation: UILabel = {
        let location = UILabel()
        location.font = .systemFont(ofSize: 18, weight: .regular)
        location.translatesAutoresizingMaskIntoConstraints = false
        return location
    }()
    
    private lazy var detailedAddress: UILabel = {
        let address = UILabel()
        address.font = .systemFont(ofSize: 18, weight: .regular)
        address.translatesAutoresizingMaskIntoConstraints = false
        return address
    }()
    
    private lazy var detailedShowOnMap: UILabel = {
        let map = UILabel()
        map.font = .systemFont(ofSize: 18, weight: .regular)
        map.text = "Показать на карте"
        map.textColor = UIColor(named: "avitoBlue")
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private lazy var detailedPhoneNumber: UILabel = {
        let number = UILabel()
        number.font = .systemFont(ofSize: 16, weight: .regular)
        number.textColor = .gray
        number.translatesAutoresizingMaskIntoConstraints = false
        return number
    }()
    
    private lazy var detailedEmail: UILabel = {
        let email = UILabel()
        email.font = .systemFont(ofSize: 16, weight: .regular)
        email.textColor = .gray
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    private lazy var callButton: UIButton = {
        let call = UIButton(configuration: .filled())
        call.tintColor = UIColor(named: "avitoGreen")
        call.setImage(UIImage(systemName: "phone.fill"), for: .normal)
        call.setTitle("  Позвонить", for: .normal)
        call.translatesAutoresizingMaskIntoConstraints = false
        return call
    }()
    
    private lazy var chatButton: UIButton = {
        let chat = UIButton(configuration: .filled())
        chat.tintColor = UIColor(named: "avitoBlue")
        chat.setImage(UIImage(systemName: "message.fill"), for: .normal)
        chat.setTitle("  Написать", for: .normal)
        chat.addTarget(self, action: #selector(chatButtonTapped), for: .touchUpInside)
        chat.translatesAutoresizingMaskIntoConstraints = false
        return chat
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var detailedDescriptionTitle: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 20, weight: .bold)
        title.text = "Описание"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var detailedDescription: UILabel = {
        let description = UILabel()
        description.font = .systemFont(ofSize: 18, weight: .regular)
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private lazy var detailedCreatedDate: UILabel = {
        let date = UILabel()
        date.font = .systemFont(ofSize: 14, weight: .regular)
        date.textColor = .gray
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.navigationController?.navigationBar.topItem?.title = "Назад"
        
        if let itemId = itemId {
            loadProductData(itemId: itemId)
        } else {
            print("itemId отсутствует")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateScrollViewContentSize()
    }
    
    
    //MARK: - Methods
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(detailedImage)
        scrollView.addSubview(detailedTitle)
        scrollView.addSubview(detailedPrice)
        scrollView.addSubview(detailedLocation)
        scrollView.addSubview(detailedAddress)
        scrollView.addSubview(detailedShowOnMap)
        scrollView.addSubview(detailedPhoneNumber)
        scrollView.addSubview(detailedEmail)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(callButton)
        stackView.addArrangedSubview(chatButton)
        scrollView.addSubview(detailedDescriptionTitle)
        scrollView.addSubview(detailedDescription)
        scrollView.addSubview(detailedCreatedDate)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            detailedImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            detailedImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            detailedImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            detailedImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            detailedImage.heightAnchor.constraint(equalTo: detailedImage.widthAnchor, multiplier: 1.0),
            
            detailedTitle.topAnchor.constraint(equalTo: detailedImage.bottomAnchor, constant: 16),
            detailedTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            detailedPrice.topAnchor.constraint(equalTo: detailedTitle.bottomAnchor, constant: 8),
            detailedPrice.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            detailedLocation.topAnchor.constraint(equalTo: detailedPrice.bottomAnchor, constant: 16),
            detailedLocation.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            detailedAddress.topAnchor.constraint(equalTo: detailedLocation.bottomAnchor, constant: 4),
            detailedAddress.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            detailedShowOnMap.topAnchor.constraint(equalTo: detailedAddress.bottomAnchor, constant: 8),
            detailedShowOnMap.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            stackView.topAnchor.constraint(equalTo: detailedShowOnMap.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            callButton.heightAnchor.constraint(equalToConstant: 50),
            chatButton.heightAnchor.constraint(equalToConstant: 50),
            
            detailedDescriptionTitle.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            detailedDescriptionTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            detailedDescription.topAnchor.constraint(equalTo: detailedDescriptionTitle.bottomAnchor, constant: 8),
            detailedDescription.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            detailedDescription.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            detailedPhoneNumber.topAnchor.constraint(equalTo: detailedDescription.bottomAnchor, constant: 16),
            detailedPhoneNumber.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            detailedEmail.topAnchor.constraint(equalTo: detailedPhoneNumber.bottomAnchor, constant: 4),
            detailedEmail.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            detailedCreatedDate.topAnchor.constraint(equalTo: detailedEmail.bottomAnchor, constant: 4),
            detailedCreatedDate.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16)
        ])
    }
    
    private func updateScrollViewContentSize() {
        var contentRect = CGRect.zero
        for subview in scrollView.subviews {
            contentRect = contentRect.union(subview.frame)
        }
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: contentRect.height)
    }
    
    func loadProductData(itemId: String) {
        
        stateofLoading = .loading
        
        let urlString = "https://www.avito.st/s/interns-ios/details/\(itemId).json"
        guard let url = URL(string: urlString) else { return }
        
        NetworkService.fetchDetailedData(from: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let product):
                    self.selectedProduct = product
                    self.stateofLoading = .content
                    self.updateProductData(with: product)
                case .failure(let error):
                    self.stateofLoading = .error
                    print("Error loading item:", error)
                }
            }
        }
    }
    
    func updateProductData(with product: Products) {
        
        detailedTitle.text = product.title
        detailedPrice.text = product.price
        detailedLocation.text = product.location
        detailedAddress.text = product.address
        detailedPhoneNumber.text = product.phoneNumber
        detailedEmail.text = product.email
        detailedDescription.text = product.description
        detailedCreatedDate.text = product.createdDate
        
        if let imageUrl = URL(string: product.imageUrl) {
            
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl),
                   let image = UIImage(data: imageData) {
                    
                    DispatchQueue.main.async {
                        self.detailedImage.image = image
                    }
                }
            }
            
        }
    }
    
    @objc
    private func chatButtonTapped() {
        let chatVC = MessagesViewController()
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
}
