//
//  Price.swift
//  IKEA
//
//  Created by Fady Yecob on 09/08/2021.
//

import Foundation

struct Price: Decodable, Equatable {
    let value: Decimal
    let currency: String
}
