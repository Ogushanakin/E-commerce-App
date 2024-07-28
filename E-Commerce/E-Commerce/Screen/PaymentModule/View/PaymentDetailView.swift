//
//  PaymentDetailView.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import UIKit

protocol PaymentDetailsViewInterface: AnyObject {
    func paymentDetailsView(_ view: PaymentDetailsView, didUpdateCardNumber cardNumber: String)
    func paymentDetailsView(_ view: PaymentDetailsView, didUpdateExpiryDate expiryDate: String)
    func paymentDetailsView(_ view: PaymentDetailsView, didUpdateCVV cvv: String)
    func paymentDetailsView(_ view: PaymentDetailsView, didUpdateAmount amount: String)
    func paymentDetailsViewDidTapStartPayment(_ view: PaymentDetailsView)
}

final class PaymentDetailsView: UIView {
    
    // MARK: - UI Elements
    
    private let cardNumberTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Credit Card Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "creditcard.fill")!)
    private let expiryDateTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Expiry Date (MM/YY)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "calendar")!)
    private let cvvTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "CVV", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "key.horizontal.fill")!)
    let amountLabel = UILabel()
    private let startPaymentButton = UIButton()
    
    // MARK: - Properties
    
    weak var delegate: PaymentDetailsViewInterface?
    
    // MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        updateStartPaymentButtonState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        backgroundColor = .white
        
        let textFields = [cardNumberTextField, expiryDateTextField, cvvTextField]
        textFields.forEach { textField in
            textField.borderStyle = .roundedRect
            textField.delegate = self
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            addSubview(textField)
        }
        addSubview(amountLabel)
        
        cardNumberTextField.placeholder = "Card Number"
        expiryDateTextField.placeholder = "Expiry Date (MM/YY)"
        cvvTextField.placeholder = "CVV"
        amountLabel.sizeToFit()
        
        startPaymentButton.setTitle("Start Payment", for: .normal)
        startPaymentButton.setTitleColor(.white, for: .normal)
        startPaymentButton.backgroundColor = .lightGray // Başlangıçta butonu devre dışı bırak
        startPaymentButton.layer.cornerRadius = 5
        startPaymentButton.addTarget(self, action: #selector(startPayment), for: .touchUpInside)
        addSubview(startPaymentButton)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        cardNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-20)
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
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Actions
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case cardNumberTextField:
            delegate?.paymentDetailsView(self, didUpdateCardNumber: textField.text ?? "")
        case expiryDateTextField:
            delegate?.paymentDetailsView(self, didUpdateExpiryDate: textField.text ?? "")
        case cvvTextField:
            delegate?.paymentDetailsView(self, didUpdateCVV: textField.text ?? "")
        default:
            break
        }
        updateStartPaymentButtonState()
    }
    
    @objc private func startPayment() {
        delegate?.paymentDetailsViewDidTapStartPayment(self)
    }
    
    private func updateStartPaymentButtonState() {
        let isCardNumberValid = !(cardNumberTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isExpiryDateValid = !(expiryDateTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isCVVValid = !(cvvTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        
        let isValid = isCardNumberValid && isExpiryDateValid && isCVVValid
        startPaymentButton.isEnabled = isValid
        startPaymentButton.backgroundColor = isValid ? .systemBlue : .lightGray
    }
}

// MARK: - UITextFieldDelegate

extension PaymentDetailsView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
