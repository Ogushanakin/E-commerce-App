//
//  ViewController.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import UIKit
import SnapKit

class PaymentDetailsViewController: UIViewController, UITextFieldDelegate {
    
    var onPaymentInitiated: (() -> Void)?
    
    private let cardNumberTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Credit Card Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "creditcard.fill")!)
    private let expiryDateTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Expiry Date (MM/YY)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "calendar")!)
    private let cvvTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "CVV", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "key.horizontal.fill")!)
    let amountLabel = UILabel()
    private let startPaymentButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateButtonState()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let textFields = [cardNumberTextField, expiryDateTextField, cvvTextField]
        textFields.forEach { textField in
            textField.borderStyle = .roundedRect
            textField.delegate = self
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            view.addSubview(textField)
        }
        view.addSubview(amountLabel)
        
        cardNumberTextField.placeholder = "Card Number"
        expiryDateTextField.placeholder = "Expiry Date (MM/YY)"
        cvvTextField.placeholder = "CVV"
        amountLabel.sizeToFit()
        
        startPaymentButton.setTitle("Start Payment", for: .normal)
        startPaymentButton.setTitleColor(.white, for: .normal)
        startPaymentButton.backgroundColor = .lightGray // Başlangıçta butonu devre dışı bırak
        startPaymentButton.layer.cornerRadius = 5
        startPaymentButton.addTarget(self, action: #selector(startPayment), for: .touchUpInside)
        view.addSubview(startPaymentButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        cardNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(44)
        }
        
        expiryDateTextField.snp.makeConstraints { make in
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(10)
            make.left.right.height.equalTo(cardNumberTextField)
        }
        
        cvvTextField.snp.makeConstraints { make in
            make.top.equalTo(expiryDateTextField.snp.bottom).offset(10)
            make.left.right.height.equalTo(cardNumberTextField)
        }
        
        amountLabel.textColor = .black
        amountLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(cvvTextField.snp.bottom).offset(10)
            make.left.right.height.equalTo(cardNumberTextField)
        }
        
        startPaymentButton.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateButtonState()
    }
    
    private func updateButtonState() {
        let cardNumberIsValid = !(cardNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let expiryDateIsValid = !(expiryDateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let cvvIsValid = !(cvvTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        
        startPaymentButton.isEnabled = cardNumberIsValid && expiryDateIsValid && cvvIsValid
        startPaymentButton.backgroundColor = startPaymentButton.isEnabled ? .blue : .lightGray
    }
    
    @objc private func startPayment() {
        guard let cardNo = cardNumberTextField.text,
              let expDate = expiryDateTextField.text,
              let cvv = cvvTextField.text else {
            showAlert(message: "Please fill in all fields correctly.")
            return
        }
        
        PaymentSDK.shared.startPayment(cardNo: cardNo, expDate: expDate, cvv: cvv, amount: amountLabel.text ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onPaymentInitiated?()
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Payment", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
