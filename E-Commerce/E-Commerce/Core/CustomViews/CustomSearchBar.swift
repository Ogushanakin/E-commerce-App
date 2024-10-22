//
//  CustomSearchBar.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 27.07.2024.
//

import UIKit

class CustomSearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(showsBookmarkButton: Bool? = nil, placeHolder: String? = nil) {
        self.init(frame: .zero)
        set(showsBookmarkButton: showsBookmarkButton, placeHolder: placeHolder)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(showsBookmarkButton: Bool? = nil, placeHolder: String? = nil) {
        if let showsBookmarkButton = showsBookmarkButton {
            self.showsBookmarkButton = showsBookmarkButton
        }
        if let placeHolder = placeHolder {
            searchTextField.placeholder = placeHolder
        }
    }
}
