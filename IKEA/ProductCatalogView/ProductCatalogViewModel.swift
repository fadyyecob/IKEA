//
//  ProductCatalogViewModel.swift
//  IKEA
//
//  Created by Fady Yecob on 10/08/2021.
//

import Foundation

class ProductCatalogViewModel {
    private let productRepository: ProductsRepository
    private let cartRepository: CartRepository
    
    private(set) var cachedProducts = [Product]()
    let title = "Product Catalog"
    
    init(
        productRepository: ProductsRepository,
        cartRepository: CartRepository
    ) {
        self.productRepository = productRepository
        self.cartRepository = cartRepository
    }
    
    func fetchProducts() -> [Product] {
        cachedProducts = productRepository.fetchProducts()
        return cachedProducts
    }
    
    func addProductToCart(id: String) {
        guard let foundProduct = cachedProducts.first(where: { $0.id == id }) else {
            return
        }
        
        cartRepository.add(product: foundProduct)
    }
}
