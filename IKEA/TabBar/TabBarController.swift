//
//  TabBarController.swift
//  IKEA
//
//  Created by Fady Yecob on 09/08/2021.
//

import UIKit
import Combine

class TabBarController: UITabBarController {
    private var cancellables = Set<AnyCancellable>()
    let viewModel: TabBarViewModelProtocol
    
    init(viewModel: TabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers = [
            makeProductCatalogNavigationController(),
            makeCartNavigationController()
        ]
    }
    
    private func makeProductCatalogNavigationController() -> UINavigationController {
        let productCatalogViewModel = ProductCatalogViewModel(
            productRepository: viewModel.appRepository.productsRepository,
            cartRepository: viewModel.appRepository.cartRepository
        )
        let productCatalogViewController = ProductCatalogViewController(viewModel: productCatalogViewModel)
        let tabBarItem = productCatalogViewController.tabBarItem
        
        let productCatalogItemViewModel = viewModel.productCatalogItem
        
        tabBarItem?.image = UIImage(systemName: productCatalogItemViewModel.image)
        tabBarItem?.title = productCatalogItemViewModel.title
        tabBarItem?.selectedImage = UIImage(systemName: productCatalogItemViewModel.selectedImage)
        
        return UINavigationController(rootViewController: productCatalogViewController)
    }
    
    private func makeCartNavigationController() -> UINavigationController {
        let cartRepository = viewModel.appRepository.cartRepository
        let cartViewModel = CartViewModel(cartRepository: cartRepository)
        
        let cartViewController = CartViewController(viewModel: cartViewModel)
        let tabBarItem = cartViewController.tabBarItem
        
        let cartItemViewModel = viewModel.cartItem
        
        tabBarItem?.image = UIImage(systemName: cartItemViewModel.image)
        tabBarItem?.title = cartItemViewModel.title
        tabBarItem?.selectedImage = UIImage(systemName: cartItemViewModel.selectedImage)
        
        cartRepository.basketChangedPublisher.sink { _ in
            tabBarItem?.badgeValue = "\(cartRepository.itemCount)"
        }.store(in: &cancellables)
        
        return UINavigationController(rootViewController: cartViewController)
    }
}
