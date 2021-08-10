//
//  ProductTextFormatter.swift
//  IKEA
//
//  Created by Fady Yecob on 10/08/2021.
//

import Foundation

class ProductTextFormatter {
    func makeCurrencyAndPriceString(
        price: Price,
        quantity: Int = 1,
        currencyFormatter: NumberFormatter = CurrencyFormatter()
    ) -> String {
        let priceWithoutCurrency = currencyFormatter.string(from: NSDecimalNumber(decimal: price.value)) ?? ""
        
        return "\(priceWithoutCurrency) \(price.currency)"
    }
    
    func makeDescription(productInfo: ProductInfo) -> String {
        switch productInfo {
        case let .chair(material, color):
            return "\(material), \(color)"
        case let .couch(numberOfSeats, color):
            return "\(numberOfSeats) seats, \(color)"
        }
    }
}
