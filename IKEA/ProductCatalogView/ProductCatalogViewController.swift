//
//  ProductCatalogViewController.swift
//  IKEA
//
//  Created by Fady Yecob on 09/08/2021.
//

import UIKit

class ProductCatalogViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
    
    private var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, ProductItemViewModel>()
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, ProductItemViewModel> = {
        UICollectionViewDiffableDataSource<Section, ProductItemViewModel>(
            collectionView: collectionView,
            cellProvider: { view, indexPath, item in
                view.dequeueConfiguredReusableCell(
                    using: self.cellRegistration,
                    for: indexPath,
                    item: item
                )
            }
        )
    }()
    
    private lazy var cellRegistration: UICollectionView.CellRegistration<ProductCatalogCollectionViewCell, ProductItemViewModel> = {
        let cellNib = UINib(nibName: "ProductCatalogCollectionViewCell", bundle: nil)
        return UICollectionView.CellRegistration<ProductCatalogCollectionViewCell, ProductItemViewModel>(cellNib: cellNib) { cell, _, viewModel in
            cell.update(usingViewModel: viewModel)
            cell.setAddToBasketHandler { [weak self] in
                self?.viewModel.addProductToCart(id: viewModel.id)
            }
        }
    }()
    
    private let viewModel: ProductCatalogViewModel
    
    init(viewModel: ProductCatalogViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        configureCollectionView()
        loadProducts()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let isCompact = layoutEnvironment.traitCollection.horizontalSizeClass == .compact
            
            let cellWidth: NSCollectionLayoutDimension = isCompact ? .fractionalWidth(0.5) : .absolute(200)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: cellWidth, heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: cellWidth)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            return NSCollectionLayoutSection(group: group)
        }
        
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = dataSource
    }
    
    private func loadProducts() {
        let products = viewModel.fetchProducts()
            .map { ProductItemViewModel(product: $0) }

        dataSourceSnapshot.deleteAllItems()
        dataSourceSnapshot.appendSections([.main])
        dataSourceSnapshot.appendItems(products, toSection: .main)
        dataSource.apply(dataSourceSnapshot)
     }

}

private extension ProductCatalogViewController {
    enum Section {
        case main
    }
}
