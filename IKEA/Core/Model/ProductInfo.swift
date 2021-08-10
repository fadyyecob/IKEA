//
//  ProductInfo.swift
//  IKEA
//
//  Created by Fady Yecob on 09/08/2021.
//

import Foundation

enum ProductInfo: Decodable, Equatable {
    case couch(numberOfSeats: Int, color: String)
    case chair(material: String, color: String)
    
    enum CodingKeys: String, CodingKey {
        case numberOfSeats
        case material
        case color
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let color = try container.decode(String.self, forKey: .color)
        
        if let numberOfSeats = try? container.decodeIfPresent(Int.self, forKey: .numberOfSeats) {
            self = .couch(numberOfSeats: numberOfSeats, color: color)
        } else {
            let material = try container.decode(String.self, forKey: .material)
            self = .chair(material: material, color: color)
        }
    }
}
