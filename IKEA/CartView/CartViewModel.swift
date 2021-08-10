//
//  CartViewModel.swift
//  IKEA
//
//  Created by Fady Yecob on 10/08/2021.
//

import Foundation

class CartViewModel {
    private let cartRepository: CartRepository
    private let currencyFormatter: CurrencyFormatter

    let title = "Cart"
    
    lazy var basketChangedPublisher = cartRepository.basketChangedPublisher
    
    init(
        cartRepository: CartRepository,
        currencyFormatter: CurrencyFormatter = CurrencyFormatter()
    ) {
        self.cartRepository = cartRepository
        self.currencyFormatter = currencyFormatter
    }
    
    var totalAmountText: String {
        let totalPrice = currencyFormatter.string(from: NSDecimalNumber(decimal: cartRepository.totalPrice)) ?? ""
        let currency = cartRepository.cartItems.first?.product.price.currency ?? ""
        
        return "Total: \(totalPrice) \(currency)"
    }
    
    var cartItems: [CartItemViewModel] {
        cartRepository.cartItems
            .map {
                let amount = $0.amount
                let productItemViewModel = ProductItemViewModel(product: $0.product)
                
                return CartItemViewModel(productItemViewModel: productItemViewModel, amount: amount)
            }
    }
    
    func removeItem(atIndex index: Int) {
        let cartItem = cartRepository.cartItems[index]
        cartRepository.remove(product: cartItem.product)
    }
}
