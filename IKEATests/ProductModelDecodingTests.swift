//
//  ProductModelTests.swift
//  IKEATests
//
//  Created by Fady Yecob on 09/08/2021.
//

import XCTest
@testable import IKEA

class ProductModelDecodingTests: XCTestCase {
    private var jsonData: Data!
    private var jsonDecoder: JSONDecoder!

    override func setUpWithError() throws {
        let productJSONPath = try XCTUnwrap(Bundle.main.path(forResource: "products", ofType: "json"))
        jsonData = try String(contentsOfFile: productJSONPath).data(using: .utf8)
        jsonDecoder = JSONDecoder()
    }

    override func tearDownWithError() throws {
        jsonData = nil
        jsonDecoder = nil
    }
    
    // MARK: - Tests
    
    func testProductsCount() throws {
        let decodedProducts = try jsonDecoder.decode([Product].self, from: jsonData)
        
        XCTAssertEqual(decodedProducts.count, 14)
    }
    
    func testProductTypeAndInfoMatch() throws {
        let decodedProducts = try jsonDecoder.decode([Product].self, from: jsonData)
        
        for product in decodedProducts {
            switch product.info {
            case .chair:
                XCTAssertEqual(product.type, .chair)
            case .couch:
                XCTAssertEqual(product.type, .couch)
            }
        }
    }
    
    func testPriceDecimalValues() throws {
        let decodedProducts = try jsonDecoder.decode([Product].self, from: jsonData)
        
        XCTAssertEqual(decodedProducts[4].price.value, try XCTUnwrap(Decimal(string: "695.20")))
    }

}
