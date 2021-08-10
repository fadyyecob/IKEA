//
//  ProductsRepository.swift
//  IKEA
//
//  Created by Fady Yecob on 10/08/2021.
//

import Foundation

class ProductsRepository {
    private let bundle: Bundle
    private let jsonDecoder: JSONDecoder
    
    init(
        bundle: Bundle = .main,
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        self.bundle = bundle
        self.jsonDecoder = jsonDecoder
    }
    
    func fetchProducts() -> [Product] {
        guard
            let productJSONPath = bundle.path(forResource: "products", ofType: "json"),
            let jsonData = try? String(contentsOfFile: productJSONPath).data(using: .utf8) else {
            return []
        }
        
        return (try? jsonDecoder.decode([Product].self, from: jsonData)) ?? []
    }
}
