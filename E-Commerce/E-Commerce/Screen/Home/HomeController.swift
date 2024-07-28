//
//  HomeController.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 27.07.2024.
//

import UIKit

final class HomeController: UIViewController {
    
    //MARK: - Properties
    private let homeProfileViewModel = HomeProfileViewModel()
    private let productsViewModel = ProductsViewModel()
    private let homeView = HomeView()
    
    //MARK: -  Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        homeProfileViewModel.fetchUser()
        homeProfileViewModel.fetchProfilePhoto()
        homeProfileViewModel.getTime()
        productsViewModel.fetchCart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavBar()
        collectionCellRegister()
        setupDelegates()
        productsViewModel.fetchAllProducts()
    }
    
    //MARK: - Configure ViewController
    
    private func configureViewController() {
        self.navigationController?.tabBarController?.tabBar.backgroundColor = .white
        view = homeView
    }
    
    private func configureNavBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    //MARK: - Register Custom Cell
    
    private func collectionCellRegister() {
        homeView.productCollection.register(ProductCollectionCell.self, forCellWithReuseIdentifier: ProductCollectionCell.identifier)
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        homeProfileViewModel.delegate = self
        productsViewModel.delegate = self
        homeView.interface = self
        homeView.searcBar.delegate = self
        homeView.productCollection.delegate = self
        homeView.productCollection.dataSource = self
    }
}

//MARK: - SerchBar Methods

extension HomeController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        let searchVC = SearchController()
//        navigationController?.pushViewController(searchVC, animated: true)
    }
}


//MARK: - CollectionViews Methods

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productsViewModel.productsByCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeView.productCollection.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.identifier, for: indexPath) as? ProductCollectionCell else { return UICollectionViewCell()}
        cell.interface = self
        cell.configure(data: productsViewModel.productsByCategory[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productId = productsViewModel.productsByCategory[indexPath.row].id else { return }
        productsViewModel.fetchSingleProduct(productId: productId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: homeView.productCollection.frame.width / 2 - 10, height: homeView.productCollection.frame.width / 2 + 40)
    }
}

extension HomeController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let witdh = scrollView.frame.width
//        homeView.currentPage = Int(scrollView.contentOffset.x / witdh)
    }
}

extension HomeController: HomeViewInterface {
    func homeView(_ view: HomeView, cartButtonTapped button: UIButton) {
//        let cartVC = CartController()
//        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    func homeView(_ view: HomeView, wishListButtonTapped button: UIButton) {
//        let wishListVC = WishListController()
//        navigationController?.pushViewController(wishListVC, animated: true)
    }
    
    func homeView(_ view: HomeView, seeAllButtonTapped button: UIButton) {
//        let specialProductsVC = SpecialProductsController()
//        navigationController?.pushViewController(specialProductsVC, animated: true)
    }
    
    
}



//MARK: - ProductsViewModelDelegate

extension HomeController: ProductsViewModelDelegate {
 

    func didFetchSingleProduct(_ product: Product) {
        let controller = ProductDetailController(product: product)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchAllProductsSuccessful() {
        homeView.productCollection.reloadData()
    }
    
    func didFetchProductsByCategorySuccessful() {
        homeView.productCollection.reloadData()
    }
    
    func didUpdateWishListSuccessful() {
    }
   
    func didFetchCartCountSuccessful() {
        if let cartCount = productsViewModel.cart?.count {
            if cartCount == 0 {
                tabBarController?.tabBar.items?[2].badgeValue = nil
            } else {
                tabBarController?.tabBar.items?[2].badgeValue = "\(cartCount)"
            }
        }
    }
}

//MARK: - ProductCollectionCellInterface

extension HomeController: ProductCollectionCellInterface {
    func productCollectionCell(_ view: ProductCollectionCell, productId: Int, quantity: Int, wishButtonTapped button: UIButton) {
        productsViewModel.updateWishList(productId: productId, quantity: quantity)
        
    }
}

extension HomeController: HomeProfileViewModelDelegate {
    
    func didGotCurrentTime() {
        homeView.hiLabel.text = homeProfileViewModel.hiText
    }
    
    func didFetchUserInfro() {
        homeView.usernameLabel.text = homeProfileViewModel.username
    }
    
    func didFetchProfilePhotoSuccessful(_ url: String) {
        homeView.profilePhotoImage.downloadSetImage(url: url)
    }
}
