//
//  ProductCollectionCell.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 27.07.2024.
//

import UIKit

protocol ProductCollectionCellProtocol {
    var productImage: String { get }
    var productTitle: String { get }
    var productRatingCount: String { get }
    var productSalesAmount: String { get }
    var productPrice: String { get }
    var productId: Int { get }
}

protocol ProductCollectionCellInterface: AnyObject {
    func productCollectionCell(_ view: ProductCollectionCell, productId: Int, quantity: Int, wishButtonTapped button: UIButton)
}

class ProductCollectionCell: UICollectionViewCell {

    //MARK: - Cell's Identifier
    
    static let identifier = "ProductCollectionCell"
    
    //MARK: - Creating UI Elements
    
    private var productImageView = CustomImageView(image: UIImage(systemName: "exclamationmark.circle"), tintColor: .black, backgroundColor: .white, contentMode: .scaleAspectFit, cornerRadius: 8, isUserInteractionEnabled: true)
    var addToWishListButton = CustomButton(image: UIImage(systemName: "heart"), tintColor: .black)
    private var titleLabel = CustomLabel(text: "", numberOfLines: 1, font: .boldSystemFont(ofSize: 13), textColor: .black, textAlignment: .center)
    private var ratingCountImageView = CustomImageView(image: UIImage(systemName: "star.lefthalf.fill"), tintColor: .black, backgroundColor: .systemGray6, contentMode: .scaleAspectFit, cornerRadius: 0, isUserInteractionEnabled: false)
    private var ratingCountLabel = CustomLabel(text: "", numberOfLines: 2, font: .systemFont(ofSize: 12), textColor: .black, textAlignment: .left)
    private var ratingStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 0)
    private var infoSeperatorView = CustomView(backgroundColor: .black)
    private var salesAmountLabel = CustomLabel(text: "", numberOfLines: 1, font: .systemFont(ofSize: 12), textColor: .black, textAlignment: .right)
    private var salesAmountView = CustomView(backgroundColor: .systemGray3, cornerRadius: 8)
    private var ratingSalesInfoView = CustomView(backgroundColor: .systemGray6)
    private var priceLabel = CustomLabel(text: "", numberOfLines: 1, font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .left)
    private var productInfoStackView = CustomStackView(axis: .vertical, distiribution: .fillProportionally , isHidden: false)
    
    //MARK: - Properties
    var productId: Int?
    weak var interface: ProductCollectionCellInterface?
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        layer.cornerRadius = 15
        addSubview()
        setupConstraints()
        addTarget()
        toggleAddButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureCell
    
    func configure(data: ProductCollectionCellProtocol) {
        productImageView.downloadSetImage(url: data.productImage)
        titleLabel.text = data.productTitle
        ratingCountLabel.text = data.productRatingCount
        salesAmountLabel.text = data.productSalesAmount
        priceLabel.text = " \(data.productPrice)"
        productId = data.productId
    }
 
    //MARK: - AddAction
    
    private func addTarget() {
        addToWishListButton.addTarget(self, action: #selector(addToWishListButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Buttons actions
    
    @objc private func addToWishListButtonTapped(_ button: UIButton) {
        guard let productId = productId else { return }
        if addToWishListButton.isSelected == false {
            interface?.productCollectionCell(self, productId: productId, quantity: 1, wishButtonTapped: button)
        } else {
            interface?.productCollectionCell(self, productId: productId, quantity: 0, wishButtonTapped: button)
        }
        addToWishListButton.isSelected.toggle()
    }
    
    func toggleAddButton() {
        let image = UIImage(systemName: "heart")
        let imageFilled = UIImage(systemName: "heart.fill")
        addToWishListButton.setImage(image, for: .normal)
        addToWishListButton.setImage(imageFilled, for: .selected)
    }
}

//MARK: - UI Elements AddSubiew / Constraints

extension ProductCollectionCell {
    
    ///MARK: - AddSubview
    
    private func addSubview() {
        addSubviews(productImageView, productInfoStackView)
        addButtonToImageView()
        addRatingElementsToStackView()
        addSalesAmountLabelToView()
        addRatingSalesInfosToView()
        addProductInfosToStackView()
    }
    
    private func addButtonToImageView() {
        productImageView.layer.shadowColor = UIColor.black.cgColor
        productImageView.layer.shadowOpacity = 0.3
        productImageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        productImageView.layer.shadowRadius = 2
        productImageView.addSubview(addToWishListButton)
    }
    
    private func addRatingElementsToStackView() {
        ratingStackView.addArrangedSubviews(ratingCountImageView, ratingCountLabel)
    }
    
    private func addSalesAmountLabelToView() {
        salesAmountView.addSubview(salesAmountLabel)
    }
    
    private func addRatingSalesInfosToView() {
        ratingSalesInfoView.addSubviews(ratingStackView, infoSeperatorView, salesAmountView)
    }
    
    private func addProductInfosToStackView() {
        productInfoStackView.addArrangedSubviews(titleLabel, ratingSalesInfoView, priceLabel)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        productImageConstraints()
        wishListButtonConstraints()
        productInfosStackViewConstraints()
        seperatorViewConstraints()
        ratingImageViewConstraints()
        ratingSalesInfosViewConstraints()
        ratingStackViewConstraints()
        seperatorViewConstraints()
        salesAmountViewConstraints()
        salesAmountLabelConstraints()
    }
    
    private func productImageConstraints() {
        productImageView.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            make.top.equalTo(safeAreaLayoutGuide).offset(3)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(3)
        }
    }
    
    private func wishListButtonConstraints() {
        addToWishListButton.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.top).offset(10)
            make.trailing.equalTo(productImageView.snp.trailing).offset(-10)
        }
    }
    
    private func ratingImageViewConstraints() {
        ratingCountImageView.snp.makeConstraints { make in
            make.height.equalTo(15)
        }
    }
    
    private func ratingStackViewConstraints() {
        ratingStackView.snp.makeConstraints { make in
            make.centerY.equalTo(ratingSalesInfoView.snp.centerY)
            make.leading.equalTo(productInfoStackView.snp.leading)
        }
    }
    
    private func seperatorViewConstraints() {
        infoSeperatorView.snp.makeConstraints { make in
            make.height.equalTo(12)
            make.width.equalTo(0.75)
            make.centerY.equalTo(ratingSalesInfoView.snp.centerY)
            make.leading.equalTo(ratingStackView.snp.trailing).offset(10)
        }
    }
    
    private func salesAmountViewConstraints() {
        salesAmountView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.centerY.equalTo(ratingSalesInfoView.snp.centerY)
            make.width.equalTo(salesAmountLabel.snp.width).offset(25)
            make.leading.equalTo(infoSeperatorView.snp.trailing).offset(10)
        }
    }
    
    private func salesAmountLabelConstraints() {
        salesAmountLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(salesAmountView)
        }
    }
    
    private func ratingSalesInfosViewConstraints() {
        ratingSalesInfoView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(productImageView)
            make.height.equalTo(20)
        }
    }
    
    private func productInfosStackViewConstraints() {
        productInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(7)
            make.trailing.leading.equalTo(productImageView)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
