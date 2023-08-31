//
//  ProductsController.swift
//  Avito_Trainee_Olga_Boyko
//
//  Created by Olya B on 31.08.2023.
//

import Foundation

class ProductsController {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadProducts(completion: @escaping ([Products]) -> Void, onError: @escaping (Error) -> Void) {
        NetworkService.fetchData(for: .products) { result in
                switch result {
                case .success(let products):
                    completion(products)
                case .failure(let error):
                    onError(error)
                }
            }
        }
}
