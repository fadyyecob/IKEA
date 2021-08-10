//
//  CartViewController.swift
//  IKEA
//
//  Created by Fady Yecob on 09/08/2021.
//

import UIKit
import Combine

class CartViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var noItemsLabel: UILabel!
    
    private var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, CartItemViewModel>()
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, CartItemViewModel> = {
        UICollectionViewDiffableDataSource<Section, CartItemViewModel>(
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
    
    private lazy var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, CartItemViewModel> = {
        UICollectionView.CellRegistration { cell, _, viewModel in
            var config = cell.defaultContentConfiguration()
            
            let productItemViewModel = viewModel.productItemViewModel

            config.text = viewModel.namePriceAndQuantity
            config.secondaryText = productItemViewModel.description
            
            UIImage.load(fromURL: productItemViewModel.imageURL) { image in
                config.image = image?.scalePreservingAspectRatio(targetSize: .init(width: 37, height: 37))
                cell.contentConfiguration = config
            }
            
            cell.contentConfiguration = config
        }
    }()
    
    private let viewModel: CartViewModel
    
    init(viewModel: CartViewModel) {
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
        observeBasketAndUpdate()
    }
    
    private func configureCollectionView() {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.trailingSwipeActionsConfigurationProvider = { indexPath  in
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
                self?.viewModel.removeItem(atIndex: indexPath.row)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    private func observeBasketAndUpdate() {
        loadViewData()
        viewModel.basketChangedPublisher.sink { [weak self] _ in
            self?.loadViewData()
        }.store(in: &cancellables)
    }
    
    private func loadViewData() {
        loadCartItems()
        makeToolBar()
        noItemsLabel.isHidden = !viewModel.cartItems.isEmpty
    }
    
    private func loadCartItems() {
        let cartItems = viewModel.cartItems

        dataSourceSnapshot.deleteAllItems()
        dataSourceSnapshot.appendSections([.main])
        dataSourceSnapshot.appendItems(cartItems, toSection: .main)
        dataSource.apply(dataSourceSnapshot)
     }
    
    private func makeToolBar() {
        let totalAmountBarButton = UIBarButtonItem(title: viewModel.totalAmountText, style: .plain, target: nil, action: nil)
        totalAmountBarButton.tintColor = .darkText
        
        let toolBarItems: [UIBarButtonItem] = [
            .flexibleSpace(),
            totalAmountBarButton,
            .flexibleSpace()
        ]
        
        navigationController?.setToolbarHidden(false, animated: true)
        setToolbarItems(toolBarItems, animated: true)
    }
}

private extension CartViewController {
    enum Section {
        case main
    }
}

// MARK: - UICollectionViewDelegate

extension CartViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        false
    }
}
