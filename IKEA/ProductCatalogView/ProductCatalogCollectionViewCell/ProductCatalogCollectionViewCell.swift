//
//  ProductCatalogCollectionViewCell.swift
//  IKEA
//
//  Created by Fady Yecob on 10/08/2021.
//

import UIKit

class ProductCatalogCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var priceLabel: UILabel!
    private var addToBasketHandler: (() -> Void)?
    
    func update(usingViewModel viewModel: ProductItemViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        priceLabel.text = viewModel.currencyAndPrice
        
        UIImage.load(fromURL: viewModel.imageURL) { [weak self] image in
            self?.imageView.image = image
        }
    }
    
    func setAddToBasketHandler(_ addToBasketHandler: @escaping () -> Void) {
        self.addToBasketHandler = addToBasketHandler
    }
    
    @IBAction private func addToBasket() {
        addToBasketHandler?()
    }
}
