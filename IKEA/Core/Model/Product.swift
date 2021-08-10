//
//  Product.swift
//  IKEA
//
//  Created by Fady Yecob on 09/08/2021.
//

import Foundation

struct Product: Decodable, Equatable {
    let id: String
    let name: String
    let price: Price
    let info: ProductInfo
    let type: ProductType
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case info
        case type
        case imageURL = "imageUrl"
    }
}
