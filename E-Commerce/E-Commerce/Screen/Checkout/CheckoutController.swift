//
//  CheckoutController.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 27.07.2024.
//

import UIKit

final class CheckoutController: UIViewController {

    //MARK: - Properties
    let checkoutView = CheckoutView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    //MARK: - ConfigureViewController
    
    private func configureViewController() {
        view = checkoutView
    }
}
