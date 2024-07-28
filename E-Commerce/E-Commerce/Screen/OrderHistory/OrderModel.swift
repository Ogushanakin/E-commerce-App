//
//  OrderModel.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import Foundation
import FirebaseFirestore

struct Order: Codable {
    var id: String
    var date: Date
    var products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case products
    }
    
    init(id: String, date: Date, products: [Product]) {
        self.id = id
        self.date = date
        self.products = products
    }
}

extension Order {
    var toDictionary: [String: Any] {
        return [
            "date": Timestamp(date: date),
            "products": products.map { $0.toDictionary }
        ]
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else {
            print("Error: No document data")
            return nil
        }
        
        let id = document.documentID
        guard let timestamp = data["date"] as? Timestamp else {
            print("Error: Unable to find 'date' in document data: \(data)")
            return nil
        }
        
        guard let productData = data["products"] as? [[String: Any]] else {
            print("Error: Unable to find 'products' in document data: \(data)")
            return nil
        }
        
        self.id = id
        self.date = timestamp.dateValue()
        self.products = productData.compactMap { dictionary in
            print("Product dictionary: \(dictionary)")
            return Product(dictionary: dictionary)
        }
    }
}

extension Order: OrderCollectionCellProtocol {
    var orderDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
