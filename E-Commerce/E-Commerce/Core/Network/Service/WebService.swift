//
//  NetworkService.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 26.07.2024.
//

import Alamofire

protocol ServiceProtocol {
    func fetchProducts(type: AllProductsWebEndPoint ,onSuccess: @escaping ([Product]?) -> (), onError: @escaping (AFError) -> ())
    func fetchSingleProduct(type: SingleProductWebEndPoint, onSuccess:@escaping (Product?) -> (), onError: @escaping (AFError) -> ())
}

final class Service: ServiceProtocol {
    
    deinit {
        print("deinit service")
    }
    
    static let shared = Service()
    
    func fetchProducts(type: AllProductsWebEndPoint ,onSuccess: @escaping ([Product]?) -> (), onError: @escaping (AFError) -> ()) {
        var url = ""
        
        switch type {
        case.fetchAllProducts:
            url = AllProductsWebEndPoint.fetchAllProducts.path
        }
        
        NetworkManager.shared.request(path: url) { (response: [Product]) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
    
    func fetchSingleProduct(type: SingleProductWebEndPoint, onSuccess: @escaping (Product?) -> (), onError: @escaping (Alamofire.AFError) -> ()) {
        var url = ""
        
        switch type {
            
        case .fetchSingleProducts(id: let id):
            url = SingleProductWebEndPoint.fetchSingleProducts(id: id).path
        }
        
        NetworkManager.shared.request(path: url) { (response: Product) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
}
