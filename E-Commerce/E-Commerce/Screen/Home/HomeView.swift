//
//  HomeView.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 27.07.2024.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func homeView(_ view: HomeView, cartButtonTapped button: UIButton)
    func homeView(_ view: HomeView, wishListButtonTapped button: UIButton)
    func homeView(_ view: HomeView, seeAllButtonTapped button: UIButton )
}

final class HomeView: UIView {
 
    //MARK: - Creating UI Elements
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private var contentView = CustomView()
    var profilePhotoImage = CustomImageView(image: UIImage(systemName: "person.circle")!, tintColor: .black, backgroundColor: .systemGray6, contentMode: .scaleToFill, maskedToBounds: true, cornerRadius: 25, isUserInteractionEnabled: false)
    var hiLabel = CustomLabel(text: "Good morning👋", numberOfLines: 0, font: .systemFont(ofSize: 15), textColor: .systemGray, textAlignment: .left)
    var usernameLabel = CustomLabel(text: "", numberOfLines: 0, font: .boldSystemFont(ofSize: 20), textColor: .black, textAlignment: .left)
    private var labelStackView = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 10, isHidden: false)
    private var wishListButton = CustomButton(backgroundColor: .systemGray6, cornerRadius: 15, image: UIImage(systemName: "heart"), tintColor: .black)
    private var cartButton = CustomButton(backgroundColor: .systemGray6, cornerRadius: 15, image: UIImage(systemName: "cart"), tintColor: .black)
    private var buttonStackView = CustomStackView(axis: .horizontal, distiribution: .fillEqually, isHidden: false)
    var searcBar = CustomSearchBar(showsBookmarkButton: false, placeHolder: "Search Products")
    var productCollection = CustomCollection(backgroundColor: .systemGray6, showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .vertical)
    
    //MARK: - Properties
    
    weak var interface: HomeViewInterface?
    
    //MARK: - Init Method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .systemGray6
        searcBar.barTintColor = .systemGray6
        addSubview()
        setupConstraints()
        configureSearchBar()
        addTarget()
    }
    
    //MARK: - AddAction
    
    private func addTarget() {
        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        wishListButton.addTarget(self, action: #selector(wishListButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Buttons actions
    
    @objc private func cartButtonTapped(_ button: UIButton) {
        interface?.homeView(self, cartButtonTapped: button)
    }
    
    @objc private func wishListButtonTapped(_ button: UIButton) {
        interface?.homeView(self, wishListButtonTapped: button)
    }
    
    //MARK: - Configure SearchBar
    
    private func configureSearchBar() {
        searcBar.setImage(UIImage(systemName: "slider.horizontal.3"), for: .bookmark, state: .normal)
    }
}

//MARK: - UI Elements AddSubview / Constraints

extension HomeView {
    
    //MARK: - AddSubView
    
    private func addSubview() {
        addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(profilePhotoImage, labelStackView, buttonStackView, searcBar, productCollection)
        addTopLabelsToStackView()
        addTopButtonsToStackView()
    }
    
    private func addTopLabelsToStackView() {
        labelStackView.addArrangedSubviews(hiLabel, usernameLabel)
    }
    
    private func addTopButtonsToStackView() {
        buttonStackView.addArrangedSubviews(wishListButton, cartButton)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        scrollViewConstraints()
        contentViewConstraints()
        profilePhotoImageConstraints()
        topLabelsStackViewConstraints()
        topButtonsStackViewConstraints()
        searchBarConstraints()
        productsCollectionConstraint()
    }
    
    private func scrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func contentViewConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(2000)
        }
    }
    
    private func profilePhotoImageConstraints() {
        profilePhotoImage.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.top.equalTo(contentView).offset(15)
            make.leading.equalTo(contentView).offset(15)
        }
    }
    
    private func topLabelsStackViewConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.centerY.equalTo(profilePhotoImage.snp.centerY)
            make.leading.equalTo(profilePhotoImage.snp.trailing).offset(5)
        }
    }
    
    private func topButtonsStackViewConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(labelStackView.snp.height)
            make.centerY.equalTo(profilePhotoImage.snp.centerY)
            make.leading.equalTo(labelStackView.snp.trailing)
            make.trailing.equalTo(contentView).offset(-15)
        }
    }
    
    private func searchBarConstraints() {
        searcBar.snp.makeConstraints { make in
            make.top.equalTo(profilePhotoImage.snp.bottom).offset(15)
            make.leading.equalTo(profilePhotoImage.snp.leading)
            make.trailing.equalTo(buttonStackView.snp.trailing)
        }
    }
    
    private func productsCollectionConstraint() {
        productCollection.snp.makeConstraints { make in
            make.top.equalTo(searcBar.snp.bottom).offset(20)
            make.trailing.equalTo(searcBar.snp.trailing)
            make.leading.equalTo(searcBar.snp.leading)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}
