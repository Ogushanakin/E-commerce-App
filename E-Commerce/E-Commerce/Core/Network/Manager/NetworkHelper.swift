//
//  NetworkHelper.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 26.07.2024.
//

import Foundation

//MARK: - NetworkEndPoint

enum NetworkEndPoint: String {
    case BASE_URL = "https://fakestoreapi.com"
}

final class NetworkHelper {
    deinit {
        print("deinit networkhelper")
    }
    static let shared = NetworkHelper()

    func requestUrl(url: String) -> String {
        if let url = "\(NetworkEndPoint.BASE_URL.rawValue)\(url)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return url
        }
        return "https://fakestoreapi.com/products"
    }
}
