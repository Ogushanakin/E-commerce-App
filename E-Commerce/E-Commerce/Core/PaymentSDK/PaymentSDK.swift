//
//  PaymentSDK.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import Foundation

class PaymentSDK {
    
    static let shared = PaymentSDK()
    
    private init() {}
    
    // Dummy implementation of startPayment
    func startPayment(cardNo: String, expDate: String, cvv: String, amount: Double, completion: @escaping (Result<Bool, Error>) -> Void) {
        print("Starting payment process...")
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let paymentSuccess = true
            
            if paymentSuccess {
                print("Payment started successfully.")
                completion(.success(true))
            } else {
                print("Payment failed.")
                completion(.failure(NSError(domain: "PaymentError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Payment failed"])))
            }
        }
    }
    
    // Dummy implementation of confirmPayment
    func confirmPayment(otp: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        print("Confirming payment...")
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let validOtp = otp == "123456"
            
            if validOtp {
                print("Payment confirmed successfully.")
                completion(.success(true))
            } else {
                print("Invalid OTP.")
                completion(.failure(NSError(domain: "PaymentError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid OTP"])))
            }
        }
    }
}
