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

extension NSDate {
    func getCurrentHour() -> Int {
        let currentDateTime = Date()
        let calendar = NSCalendar.current
        let component = calendar.component(.hour, from: currentDateTime)
        let hour = component
        return hour
    }
}

extension UIImageView {
    
    func downloadSetImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
