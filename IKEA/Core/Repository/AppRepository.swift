//
//  AppRepository.swift
//  IKEA
//
//  Created by Fady Yecob on 10/08/2021.
//

import Foundation

class AppRepository {
    let productsRepository: ProductsRepository
    let cartRepository: CartRepository
    
    init(
        productsRepository: ProductsRepository = ProductsRepository(),
        cartRepository: CartRepository = CartRepository()
    ) {
        self.productsRepository = productsRepository
        self.cartRepository = cartRepository
    }
}
