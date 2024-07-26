//
//  Extensions.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 26.07.2024.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}

struct JSON {
    static let encoder = JSONEncoder()
}

extension Encodable {
    
    var dictionary: [String: Any] {
        let data = (try? JSON.encoder.encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
    }
    
}
