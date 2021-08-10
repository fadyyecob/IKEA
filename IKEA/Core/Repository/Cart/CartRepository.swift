//
//  CartRepository.swift
//  IKEA
//
//  Created by Fady Yecob on 10/08/2021.
//

import Foundation
import Combine

class CartRepository {
    private(set) var cartItems = [CartItem]()
    
    private lazy var basketChangedPassthroughPublisher = PassthroughSubject<Void, Never>()
    lazy var basketChangedPublisher = basketChangedPassthroughPublisher.eraseToAnyPublisher()
    
    var itemCount: Int {
        var totalItemCount = 0
        cartItems.forEach {
            totalItemCount += $0.amount
        }
        
        return totalItemCount
    }
    
    func add(product: Product) {
        if let foundProduct = cartItems.first(where: { $0.product == product }) {
            foundProduct.incrementAmount()
        } else {
            let cartItem = CartItem(product: product)
            cartItems.append(cartItem)
        }
        
        basketChangedPassthroughPublisher.send()
    }
}
