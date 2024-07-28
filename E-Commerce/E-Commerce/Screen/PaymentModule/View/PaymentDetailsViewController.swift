//
//  ViewController.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import UIKit

final class PaymentDetailsViewController: UIViewController, PaymentDetailsViewInterface {
    
    private let paymentDetailsView = PaymentDetailsView()
    let viewModel = PaymentDetailsViewModel()
    
    var onPaymentInitiated: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(paymentDetailsView)
        paymentDetailsView.delegate = self
        
        paymentDetailsView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        paymentDetailsView.amountLabel.text = viewModel.amount
    }
    
    func paymentDetailsView(_ view: PaymentDetailsView, didUpdateCardNumber cardNumber: String) {
        viewModel.updateCardNumber(cardNumber)
    }
    
    func paymentDetailsView(_ view: PaymentDetailsView, didUpdateExpiryDate expiryDate: String) {
        viewModel.updateExpiryDate(expiryDate)
    }
    
    func paymentDetailsView(_ view: PaymentDetailsView, didUpdateCVV cvv: String) {
        viewModel.updateCVV(cvv)
    }
    
    func paymentDetailsView(_ view: PaymentDetailsView, didUpdateAmount amount: String) {
        viewModel.updateAmount(amount)
        view.amountLabel.text = amount
    }
    
    func paymentDetailsViewDidTapStartPayment(_ view: PaymentDetailsView) {
        onPaymentInitiated?()
    }
}
