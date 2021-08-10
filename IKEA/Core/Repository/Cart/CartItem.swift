//
//  CartItem.swift
//  IKEA
//
//  Created by Fady Yecob on 10/08/2021.
//

import Foundation

class CartItem {
    let product: Product
    private(set) var amount: Int
    
    var totalPrice: Decimal {
        product.price.value * Decimal(amount)
    }
    
    init(product: Product, amount: Int = 1) {
        self.product = product
        self.amount = amount
    }
    
    func incrementAmount() {
        amount += 1
    }
}
