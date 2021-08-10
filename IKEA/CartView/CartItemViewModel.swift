//
//  CartItemViewModel.swift
//  IKEA
//
//  Created by Fady Yecob on 10/08/2021.
//

import Foundation

struct CartItemViewModel: Hashable {
    let productItemViewModel: ProductItemViewModel
    let amount: Int
    
    var namePriceAndQuantity: String {
        "\(productItemViewModel.name) (\(amount) x \(productItemViewModel.currencyAndPrice))"
    }
}
