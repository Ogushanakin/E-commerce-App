//
//  OrderHistoryController.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import UIKit

final class OrderHistoryController: UIViewController {
    deinit {
        print("OrderHistoryController deinit")
    }
    
    // MARK: - Properties
    
    private let orderHistoryViewModel = OrderHistoryViewModel()
    private let orderHistoryView = OrderHistoryView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        collectionCellRegister()
        setupDelegates()
        orderHistoryViewModel.fetchOrderHistory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderHistoryViewModel.fetchOrderHistory()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.orderHistoryView.orderHistoryCollection.reloadData()
        })
    }
    
    // MARK: - Configure ViewController
    
    private func configureViewController() {
        title = "Order History"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.tabBarController?.tabBar.backgroundColor = .white
        view = orderHistoryView
    }
    
    // MARK: - Register Custom Cell
    
    private func collectionCellRegister() {
        orderHistoryView.orderHistoryCollection.register(OrderCollectionCell.self, forCellWithReuseIdentifier: OrderCollectionCell.identifier)
    }
    
    // MARK: - Setup Delegates
    
    private func setupDelegates() {
        orderHistoryViewModel.delegate = self
        orderHistoryView.interface = self
        orderHistoryView.orderHistoryCollection.delegate = self
        orderHistoryView.orderHistoryCollection.dataSource = self
    }
}

// MARK: - CollectionView Methods

extension OrderHistoryController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderHistoryViewModel.orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = orderHistoryView.orderHistoryCollection.dequeueReusableCell(withReuseIdentifier: OrderCollectionCell.identifier, for: indexPath) as? OrderCollectionCell else { return UICollectionViewCell()}
        cell.configure(data: orderHistoryViewModel.orders[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        orderHistoryView.interface?.orderHistoryView(orderHistoryView, didSelectOrderAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: orderHistoryView.orderHistoryCollection.frame.width - 30, height: 200)
    }
}

// MARK: - OrderHistoryViewInterface

extension OrderHistoryController: OrderHistoryViewInterface {
    func orderHistoryView(_ view: OrderHistoryView, didSelectOrderAt indexPath: IndexPath) {
        // Handle order selection, e.g., navigate to order details view
    }
}

// MARK: - OrderHistoryViewModelDelegate

extension OrderHistoryController: OrderHistoryViewModelDelegate {
    
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchOrderHistory() {
        orderHistoryView.orderHistoryCollection.reloadData()
    }
}
