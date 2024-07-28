//
//  OrderCollectionCell.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import UIKit

protocol OrderCollectionCellProtocol {
    var orderDate: String { get }
    var products: [OrderProduct] { get }
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
        
        for product in data.products {
            let productLabel = CustomLabel(text: "\(product.title) - \(product.quantity) x $\(product.priceAsDouble)", numberOfLines: 1, font: .systemFont(ofSize: 14), textColor: .black, textAlignment: .left)
            productListStackView.addArrangedSubview(productLabel)
        }
    }
}

// MARK: - UI Elements AddSubiew / Constraints

extension OrderCollectionCell {
    
    // MARK: - AddSubview
    
    private func addSubview() {
        addSubviews(orderDateLabel, productListStackView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        orderDateLabelConstraints()
        productListStackViewConstraints()
    }
    
    private func orderDateLabelConstraints() {
        orderDateLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func productListStackViewConstraints() {
        productListStackView.snp.makeConstraints { make in
            make.top.equalTo(orderDateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
