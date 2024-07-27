//
//  CustomSearchController.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 27.07.2024.
//

import UIKit

class CustomSearchController: UISearchController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: nil)
        configure()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(searchPlaceHolder: String, showsBookmarkButton: Bool) {
        self.init(searchResultsController: nil)
        set(searchPlaceHolder: searchPlaceHolder, showsBookmarkButton: showsBookmarkButton)
    }
    

    private func configure() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(searchPlaceHolder: String, showsBookmarkButton: Bool) {
        searchBar.searchTextField.placeholder = searchPlaceHolder
        searchBar.showsBookmarkButton = showsBookmarkButton
    }

}
