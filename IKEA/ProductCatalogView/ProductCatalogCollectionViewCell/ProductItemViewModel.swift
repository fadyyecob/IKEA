//
//  ProductItemViewModel.swift
//  IKEA
//
//  Created by Fady Yecob on 10/08/2021.
//

import Foundation

struct ProductItemViewModel: Hashable {
    private let uuid = UUID()
    let id: String
    let name: String
    let imageURL: URL
    let description: String
    let currencyAndPrice: String

    init(product: Product, productTextFormatter: ProductTextFormatter = ProductTextFormatter()) {
        id = product.id
        name = product.name
        imageURL = product.imageURL
        description = productTextFormatter.makeDescription(productInfo: product.info)
        currencyAndPrice = productTextFormatter.makeCurrencyAndPriceString(price: product.price)
    }
}
