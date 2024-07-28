//
//  OTPController.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import UIKit
import SnapKit

class OTPViewController: UIViewController, UITextFieldDelegate {
    
    var onOTPVerified: ((Bool) -> Void)?
    
    private let otpStackView = UIStackView()
    private let confirmPaymentButton = UIButton()
    private var otpTextFields = [UITextField]()
    
    private let numberOfFields = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        otpStackView.axis = .horizontal
        otpStackView.spacing = 10
        otpStackView.distribution = .fillEqually
        view.addSubview(otpStackView)
        
        for _ in 0..<numberOfFields {
            let textField = createOTPTextField()
            otpStackView.addArrangedSubview(textField)
            otpTextFields.append(textField)
        }
        
        confirmPaymentButton.setTitle("Confirm Payment", for: .normal)
        confirmPaymentButton.setTitleColor(.white, for: .normal)
        confirmPaymentButton.backgroundColor = .green
        confirmPaymentButton.layer.cornerRadius = 5
        confirmPaymentButton.addTarget(self, action: #selector(confirmPayment), for: .touchUpInside)
        view.addSubview(confirmPaymentButton)
        
        setupConstraints()
    }
    
    private func createOTPTextField() -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }
    
    private func setupConstraints() {
        otpStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(44)
        }
        
        confirmPaymentButton.snp.makeConstraints { make in
            make.top.equalTo(otpStackView.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.count == 1 {
            if let index = otpTextFields.firstIndex(of: textField), index < numberOfFields - 1 {
                otpTextFields[index + 1].becomeFirstResponder()
            }
        } else if text.count == 0 {
            if let index = otpTextFields.firstIndex(of: textField), index > 0 {
                otpTextFields[index - 1].becomeFirstResponder()
            }
        }
    }
    
    @objc private func confirmPayment() {
        let otp = otpTextFields.map { $0.text ?? "" }.joined()
        
        guard otp.count == numberOfFields else {
            showAlert(message: "Please enter the complete OTP.")
            return
        }
        
        PaymentSDK.shared.confirmPayment(otp: otp) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onOTPVerified?(true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self?.navigationController?.popToRootViewController(animated: true)
                    }
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                    self?.onOTPVerified?(false)
                }
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "OTP Verification", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
