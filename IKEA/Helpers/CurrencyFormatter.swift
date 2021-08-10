//
//  CurrencyFormatter.swift
//  adidas
//
//  Created by Fady Yecob on 02/05/2021.
//

import Foundation

// Partly copied from previous project
class CurrencyFormatter: NumberFormatter {
    override init() {
        super.init()
        numberStyle = .currency
        currencySymbol = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
