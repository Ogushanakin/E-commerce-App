//
//  User.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 26.07.2024.
//

import Foundation

struct User: Codable {
    var id: String?
    var username: String?
    var email: String?
    var cart: [Int : Int]?
    var wishList: [Int: Int]?
}
