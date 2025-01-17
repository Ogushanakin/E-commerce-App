//
//  CartController.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 27.07.2024.
//

import UIKit

final class CartController: UIViewController {
    deinit {
        print("CartController deinit")
    }
    //MARK: - Properties
    private let cartViewModel = CartViewModel()
    private let cartView = CartView()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        collectionCellRegister()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartViewModel.fetchCart()
        cartView.priceLabel.text = "$\(cartViewModel.totalCost)"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.cartView.cartCollection.reloadData()
        })
    }

    //MARK: - Configure ViewController
    
    private func configureViewController() {
        title = "Cart"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.tabBarController?.tabBar.backgroundColor = .white
        view = cartView
    }
    
    //MARK: -  Register Custom Cell
    
    private func collectionCellRegister() {
        cartView.cartCollection.register(CartCollectionCell.self, forCellWithReuseIdentifier: CartCollectionCell.identifier)
    }
    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        cartViewModel.delegate = self
        
        cartView.interface = self
        
        cartView.cartCollection.delegate = self
        cartView.cartCollection.dataSource  = self
    }
}

//MARK: - CollectionView Methods

extension CartController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartViewModel.cartsProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cartView.cartCollection.dequeueReusableCell(withReuseIdentifier: CartCollectionCell.identifier, for: indexPath) as? CartCollectionCell else { return UICollectionViewCell()}
        cell.interface = self
        if let productId = cartViewModel.cartsProducts[indexPath.row].id {
            if let quantity = cartViewModel.cart?["\(productId)"] {
                cell.quantity = quantity
            }
        }
        cell.configure(data: cartViewModel.cartsProducts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productId = cartViewModel.cartsProducts[indexPath.row].id else { return }
        cartViewModel.fetchSingleProduct(productId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cartView.cartCollection.frame.width - 30, height: 150)
    }
}

//MARK: - CartViewInterface

extension CartController: CartViewInterface {
    
    func cartView(_ view: CartView, checkoutButtonTapped button: UIButton) {
        if cartViewModel.cartsProducts.isEmpty {
            Alert.alertMessage(title: "Cart is empty!", message: "Please add items to your cart.", vc: self)
        } else {
            let paymentVC = PaymentDetailsViewController()
            paymentVC.viewModel.updateAmount("Total Price: $\(cartViewModel.totalCost)")
            paymentVC.onPaymentInitiated = { [weak self] in
                let otpVC = OTPViewController()
                otpVC.onOTPVerified = { [weak self] success in
                    if success {
                        self?.cartViewModel.checkout()
                    } else {
                        Alert.alertMessage(title: "Error", message: "OTP verification failed.", vc: self!)
                    }
                }
                self?.navigationController?.pushViewController(otpVC, animated: true)
            }
            navigationController?.pushViewController(paymentVC, animated: true)
        }
    }
}

//MARK: - CartCollectionCellInterface

extension CartController: CartCollectionCellInterface {
    func cartCollectionCell(_ view: CartCollectionCell, productId: Int, stepperValueChanged quantity: Int) {
        if quantity == 0 {
            let indexPath = cartViewModel.getProductIndexPath(productId: productId)
            cartViewModel.removeProduct(index: indexPath.row, productId: String(productId))
            cartView.cartCollection.deleteItems(at: [indexPath])
        }
        cartViewModel.updateCart(productId: productId, quantity: quantity)
    }
    
    func cartCollectionCell(_ view: CartCollectionCell, productId: Int, removeButtonTapped quantity: Int) {
        let indextPath = cartViewModel.getProductIndexPath(productId: productId)
        cartViewModel.removeProduct(index: indextPath.row, productId: String(productId))
        cartView.cartCollection.deleteItems(at: [indextPath])
        cartViewModel.updateCart(productId: productId, quantity: 0)
    }
}

//MARK: - CartViewModelDelegate

extension CartController: CartViewModelDelegate {

    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didUpdateCartSuccessful() {
        cartViewModel.fetchCart()
    }
    
    func didFetchProductsFromCartSuccessful() {
        cartView.cartCollection.reloadData()
    }
    
    func didFetchCostAccToItemCount() {
        cartView.priceLabel.text = "$\(cartViewModel.totalCost)"
    }
    
    func didFetchCartCountSuccessful() {
        if let cartCount = cartViewModel.cart?.count {
            if cartCount == 0 {
                tabBarController?.tabBar.items?[2].badgeValue = nil
            } else {
                tabBarController?.tabBar.items?[2].badgeValue = "\(cartCount)"
            }
        }
    }
    
    func didFetchSingleProduct(_ product: Product) {
        let controller = ProductDetailController(product: product)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didCheckoutSuccessful() {
        let checkoutVC = CheckoutController()
        checkoutVC.modalPresentationStyle = .custom
        checkoutVC.transitioningDelegate = self
        self.present(checkoutVC, animated: true, completion: nil)
    }
    
    func didCheckoutNotSuccessful() {
        let checkoutVC = CheckoutController()
        checkoutVC.modalPresentationStyle = .custom
        checkoutVC.transitioningDelegate = self
        checkoutVC.checkoutView.configure()
        self.present(checkoutVC, animated: true, completion: nil)
    }
}

//MARK: - CustomPresentationController

extension CartController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
