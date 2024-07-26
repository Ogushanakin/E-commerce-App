//
//  NetworkHelper.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 26.07.2024.
//

import Foundation

typealias Categories = [String]

enum AllProductsWebEndPoint {
    case fetchAllProducts
    
    var path: String {
        switch self {
        case .fetchAllProducts:
            return NetworkHelper.shared.requestUrl(url: "/products")
        }
    }
}

enum SingleProductWebEndPoint {
    case fetchSingleProducts(id: Int)
    
    var path: String {
        switch self {
        case .fetchSingleProducts(let id):
            return NetworkHelper.shared.requestUrl(url: "/products/\(id)")
        }
    }
}

enum ProductsSpecificCategoryWebEndPoint {
    case fetchProdudctByCategory(category: String)
    var path: String {
        switch self {
        case .fetchProdudctByCategory(let category):
            return NetworkHelper.shared.requestUrl(url: "/products/category/\(category)")
        }
    }
    
}

enum ProductCategory {
    case electronics
    case jewelery
    case mensclothing
    case womensclothing
}
 

