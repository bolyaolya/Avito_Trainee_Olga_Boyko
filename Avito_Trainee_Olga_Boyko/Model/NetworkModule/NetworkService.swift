//
//  NetworkService.swift
//  Avito_Trainee_Olga_Boyko
//
//  Created by Ольга Бойко on 25.08.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse(String)
}

struct NetworkService {
    
    //создаем задачу на парсинг json со всеми товарами + декодер
    static func fetchData(for configuration: AppConfiguration, completion: @escaping (Result<[Products], Error>) -> Void) {
        
        let urlSession = URLSession(configuration: .default)
        guard let url = URL(string: configuration.rawValue) else {
            print("🍎 Ошибка: \(NetworkError.invalidURL)")
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print("🍎 Ошибка: \(NetworkError.invalidResponse(error.localizedDescription))")
                return
            }
            
            do {
                guard let data = data else {
                    print("🍎 Данные недоступны 🍎")
                    return
                }
                
                let resp = response as! HTTPURLResponse
                let status = resp.statusCode
                guard (200...299).contains(status) else {
                    print("🍎 Ответ \n🍎 Код статуса: \(resp.statusCode)")
                    return
                }
                
                let decoder = JSONDecoder()
                let result = try decoder.decode([String: [Products]].self, from: data)
                if let products = result["advertisements"] {
                    let _ = String(data: data, encoding: .utf8) ?? ""
                    print("🍏 Данные получены 🍏")
                    completion(.success(products))
                }
            } catch {
                print("Ошибка декодирования товаров: \(error)")
            }
        }
        task.resume()
    }
    
    //создаем задачу на парсинг json описания одного товара + декодер
    static func fetchDetailedData(from url: URL, completion: @escaping (Result<Products, Error>) -> Void) {
        
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print("🍎 Ошибка: \(NetworkError.invalidResponse(error.localizedDescription))")
                return
            }
            
            do {
                guard let data = data else {
                    print("🍎 Данные недоступны 🍎")
                    return
                }
                
                let resp = response as! HTTPURLResponse
                let status = resp.statusCode
                guard (200...299).contains(status) else {
                    print("🍎 Ответ \n🍎 Код статуса: \(resp.statusCode)")
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let product = try decoder.decode(Products.self, from: data)
                    completion(.success(product))
                }
            } catch {
                print("Ошибка декодирования товаров: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
