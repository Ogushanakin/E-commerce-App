//
//  Product.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 26.07.2024.
//

import Foundation

struct Product: Codable, ProductCollectionCellProtocol, ProductDetailViewProtocol, CartCollectionCellProtocol {
    
    let id: Int?
    let title: String?
    let price: Double?
    let productDescription: String?
    let category: Category?
    let image: String?
    let rating: Rating?
    let quantity: Int? // quantity field added
    
    enum CodingKeys: String, CodingKey {
        case id, title, price
        case productDescription = "description"
        case category, image, rating, quantity
    }
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? Int
        self.title = dictionary["title"] as? String
        self.price = dictionary["price"] as? Double
        self.productDescription = dictionary["description"] as? String
        self.category = Category(rawValue: dictionary["category"] as? String ?? "")
        self.image = dictionary["image"] as? String
        self.rating = Rating(dictionary: dictionary["rating"] as? [String: Any] ?? [:])
        self.quantity = dictionary["quantity"] as? Int // quantity initialization
    }
    
    var toDictionary: [String: Any] {
        return [
            "id": id ?? 0,
            "title": title ?? "",
            "price": price ?? 0.0,
            "description": productDescription ?? "",
            "category": category?.rawValue ?? "",
            "image": image ?? "",
            "rating": rating?.toDictionary ?? [:],
            "quantity": quantity ?? 0 // quantity added to dictionary
        ]
    }
    
    //MARK: - ProductCollectionCellProtocol
    
    var productId: Int {
        if let id = id {
            return id
        }
        return 0
    }
    var productImage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var productTitle: String {
        if let title = title {
            return title
        }
        return ""
    }
    
    var productRatingCount: String {
        if let rating = rating?.rate {
            return "\(rating)"
        }
        return ""
        
    }
    
    var productSalesAmount: String {
        if let salesAmount = rating?.count {
            return "\(salesAmount) sold"
        }
        return ""
    }
    
    var productPrice: String {
        if let price = price {
            return "$\(price)"
        }
        return ""
    }
    
    //MARK: - ProductDetailViewProtocol
    
    var productDetailImage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var productDetailTitle: String {
        if let title = title {
            return title
        }
        return ""
    }
    
    var productDetailSalesAmount: String {
        if let salesAmount = rating?.count {
            return "\(salesAmount) sold"
        }
        return ""
    }
    
    var productDetailRatingCount: String {
        if let ratingCount = rating?.rate {
            return "\(ratingCount)"
        }
        return ""
    }
    
    var productDetailDescription: String {
        if let description = productDescription {
            return description
        }
        return ""
    }
    
    var productDetailPrice: String {
        if let price = price {
            return "$\(price)"
        }
        return ""
    }
    
    //MARK: - CartCollectionCellProtocol
    
    var cartCellImage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var cartCellTitle: String {
        if let title = title {
            return title
        }
        return ""
    }
    
    var cartCellCategory: String {
        if let category = category {
            return category.rawValue.capitalized
        }
        return ""
    }
    
    var cartCellPrice: String {
        if let price = price {
            return "$\(price)"
        }
        return ""
    }
    
    var cartCellProductId: Int {
        if let id = id {
            return id
        }
        return 0
    }
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
    
    init(dictionary: [String: Any]) {
        self.rate = dictionary["rate"] as? Double
        self.count = dictionary["count"] as? Int
    }
    
    var toDictionary: [String: Any] {
        return [
            "rate": rate ?? 0.0,
            "count": count ?? 0
        ]
    }
}
