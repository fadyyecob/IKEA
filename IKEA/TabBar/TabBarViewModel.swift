//
//  TabBarViewModel.swift
//  IKEA
//
//  Created by Fady Yecob on 09/08/2021.
//

import Foundation

protocol TabBarViewModelProtocol {
    var productCatalogItem: TabBarItemViewModel { get }
    var cartItem: TabBarItemViewModel { get }
    var appRepository: AppRepository { get }
}

struct TabBarViewModel: TabBarViewModelProtocol {
    let appRepository: AppRepository
    
    let productCatalogItem = TabBarItemViewModel(
        title: "Product Catalog",
        image: "house",
        selectedImage: "house.fill"
    )

    let cartItem = TabBarItemViewModel(
        title: "Cart",
        image: "cart",
        selectedImage: "cart.fill"
    )
    
    init(appRepository: AppRepository) {
        self.appRepository = appRepository
    }
}
