//
//  AppConfiguration.swift
//  Avito_Trainee_Olga_Boyko
//
//  Created by Ольга Бойко on 25.08.2023.
//

import Foundation

enum AppConfiguration: String, CaseIterable {
    case products = "https://www.avito.st/s/interns-ios/main-page.json"
    case singleProduct = "https://www.avito.st/s/interns-ios/details/{itemId}.json"
}

struct Products: Decodable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let createdDate: String
    let description: String?
    let email: String?
    let phoneNumber: String?
    let address: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case location
        case imageUrl = "image_url"
        case createdDate = "created_date"
        case description
        case email
        case phoneNumber = "phone_number"
        case address
    }
}

struct SingleProductResponse: Decodable {
    let items: [Products]
}
