//
//  CustomTextField.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 26.07.2024.
//

import UIKit

final class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(isSecureTextEntry: Bool? = nil, attributedPlaceholder: NSAttributedString, image: UIImage) {
        self.init(frame: .zero)
        set(isSecureTextEntry: isSecureTextEntry, attributedPlaceholder: attributedPlaceholder, image: image)
    }
    
    private func configure() {
        autocapitalizationType = .none
        autocorrectionType = .no
        textColor = .black
        backgroundColor = .white
        leftViewMode = .always
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(isSecureTextEntry: Bool? = nil, attributedPlaceholder: NSAttributedString, image: UIImage) {
        self.attributedPlaceholder = attributedPlaceholder
        
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemGray
        
        // Container view for leftView
        let view = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + 10, height: image.size.height))
        imageView.center = view.center
        view.addSubview(imageView)
        
        leftView = view
        
        if let isSecureTextEntry = isSecureTextEntry {
            self.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    // Override textRect and editingRect to add padding
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 35, dy: 0) // Adjust left padding
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 35, dy: 0) // Adjust left padding
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 35, dy: 0) // Adjust left padding
    }
}
