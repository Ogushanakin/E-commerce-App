//
//  OrderCollectionCell.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import UIKit

protocol OrderCollectionCellProtocol {
    var orderDate: String { get }
    var products: [Product] { get }
}

final class OrderCollectionCell: UICollectionViewCell {
    deinit {
        print("OrderCollectionCell deinit")
    }
    
    // MARK: - Cell's Identifier
    
    static let identifier = "OrderCollectionCell"
    
    // MARK: - Creating UI Elements
    
    private var orderDateLabel = CustomLabel(text: "", numberOfLines: 1, font: .boldSystemFont(ofSize: 15), textColor: .black, textAlignment: .left)
    private var productListStackView = CustomStackView(axis: .vertical, distiribution: .fillEqually, spacing: 5, isHidden: false)
    private var totalPriceLabel = CustomLabel(text: "", numberOfLines: 1, font: .boldSystemFont(ofSize: 15), textColor: .black, textAlignment: .right)
    
    // MARK: - Init methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 20
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureCell
    
    func configure(data: OrderCollectionCellProtocol) {
        orderDateLabel.text = data.orderDate
        productListStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        var totalPrice: Double = 0.0
        for product in data.products {
            let productTitle = product.title ?? "Unknown"
            let productQuantity = product.quantity ?? 0
            let productPrice = product.price ?? 0.0
            totalPrice += (Double(productQuantity) * productPrice)
            let formattedProductPrice = String(format: "%.2f", productPrice)
            let productLabel = CustomLabel(text: "\(productTitle) - \(productQuantity) x $\(formattedProductPrice)", numberOfLines: 0, font: .systemFont(ofSize: 14, weight: .medium), textColor: .gray, textAlignment: .left)
            productListStackView.addArrangedSubview(productLabel)
        }
        
        let formattedTotalPrice = String(format: "%.2f", totalPrice)
        totalPriceLabel.text = "Total: $\(formattedTotalPrice)"
    }
}

// MARK: - UI Elements AddSubiew / Constraints

extension OrderCollectionCell {
    
    // MARK: - AddSubview
    
    private func addSubview() {
        addSubviews(orderDateLabel, totalPriceLabel, productListStackView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        orderDateLabelConstraints()
        totalPriceLabelConstraints()
        productListStackViewConstraints()
    }
    
    private func orderDateLabelConstraints() {
        orderDateLabel.textColor = #colorLiteral(red: 0.9821694493, green: 0.2583739161, blue: 0.4088498354, alpha: 1)
        orderDateLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(14)
            make.height.equalTo(25)
        }
    }
    private func totalPriceLabelConstraints() {
        totalPriceLabel.sizeToFit()
        totalPriceLabel.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(14)
            make.height.equalTo(25)
        }
    }
    private func productListStackViewConstraints() {
        productListStackView.snp.makeConstraints { make in
            make.top.equalTo(orderDateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(totalPriceLabel.snp.top).offset(-10)
        }
    }
}
