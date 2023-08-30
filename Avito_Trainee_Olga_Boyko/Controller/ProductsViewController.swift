//
//  ViewController.swift
//  Avito_Trainee_Olga_Boyko
//
//  Created by Ольга Бойко on 25.08.2023.
//

import UIKit

final class ProductsViewController: UIViewController {
    
    //MARK: - Properties
    
    enum State {
        case loading
        case error
        case content
    }
    
    var products: [Products] = []
    var singleProduct: SingleProductResponse?
    lazy var stateofLoading: State = .loading
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: "ProductsCellID")
        collectionView.register(LoadingCollectionViewCell.self, forCellWithReuseIdentifier: "LoadingCellID")
        collectionView.register(ErrorCollectionViewCell.self, forCellWithReuseIdentifier: "ErrorCellID")
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Поиск"
        return search
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
        navigationItem.titleView = searchBar
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        view.addSubview(collectionView)
        view.backgroundColor = .white
        setupConstraints()
    }
    
    func loadData() {
        stateofLoading = .loading
        collectionView.reloadData()
        
        NetworkService.fetchData(for: .products) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self.products = products
                    print("Number of items: \(products.count)")
                    self.stateofLoading = .content
                case .failure(let error):
                    self.stateofLoading = .error
                    print("Error loading products:", error)
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stateofLoading == .content ? products.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if stateofLoading == .content {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCellID", for: indexPath) as! ProductsCollectionViewCell
            let item = products[indexPath.row]
            cell.configure(with: item)
            return cell
        } else if stateofLoading == .loading {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCellID", for: indexPath) as! LoadingCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ErrorCellID", for: indexPath) as! ErrorCollectionViewCell
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if stateofLoading == .content {
            
            let selectedItem = products[indexPath.row]
            let detailVC = DetailViewController()
            detailVC.selectedProduct = selectedItem
            detailVC.itemId = selectedItem.id
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 8 - 8 - 8
        let cellWidth = floor(width / 2)
        let cellHeight = cellWidth + 120
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension ProductsViewController: ErrorCellDelegate {
    func retryButtonTapped() {
        loadData()
    }
}
