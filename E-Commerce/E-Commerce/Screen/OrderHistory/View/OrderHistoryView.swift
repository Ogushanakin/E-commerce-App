//
//  OrderHistoryView.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import UIKit

protocol OrderHistoryViewInterface: AnyObject {
    func orderHistoryView(_ view: OrderHistoryView, didSelectOrderAt indexPath: IndexPath)
}

final class OrderHistoryView: UIView {
    deinit {
        print("OrderHistoryView deinit")
    }
    
    weak var interface: OrderHistoryViewInterface?
    
    // MARK: - Creating UI Elements
    
    var orderHistoryCollection = CustomCollection(backgroundColor: .systemGray6, showsScrollIndicator: false, layout: UICollectionViewFlowLayout(), scrollDirection: .vertical)
    
    // MARK: - Init methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AddSubview / Constraints
    
    private func addSubview() {
        addSubview(orderHistoryCollection)
    }
    
    private func setupConstraints() {
        orderHistoryCollectionConstraints()
    }
    
    private func orderHistoryCollectionConstraints() {
        orderHistoryCollection.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

