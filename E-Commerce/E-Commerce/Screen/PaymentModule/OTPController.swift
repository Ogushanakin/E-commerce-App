//
//  OTPController.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import UIKit

class OTPViewController: UIViewController {
    
    var onOTPVerified: ((Bool) -> Void)?
    
    private let otpTextField = UITextField()
    private let confirmPaymentButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        otpTextField.borderStyle = .roundedRect
        otpTextField.placeholder = "OTP"
        view.addSubview(otpTextField)
        
        confirmPaymentButton.setTitle("Confirm Payment", for: .normal)
        confirmPaymentButton.setTitleColor(.white, for: .normal)
        confirmPaymentButton.backgroundColor = .green
        confirmPaymentButton.layer.cornerRadius = 5
        confirmPaymentButton.addTarget(self, action: #selector(confirmPayment), for: .touchUpInside)
        view.addSubview(confirmPaymentButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        otpTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(44)
        }
        
        confirmPaymentButton.snp.makeConstraints { make in
            make.top.equalTo(otpTextField.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func confirmPayment() {
        guard let otp = otpTextField.text else {
            showAlert(message: "Please enter OTP.")
            return
        }
        
        PaymentSDK.shared.confirmPayment(otp: otp) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onOTPVerified?(true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                        self?.navigationController?.popToRootViewController(animated: true)
                    })
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
