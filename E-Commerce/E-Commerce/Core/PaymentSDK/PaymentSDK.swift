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
    
    func startPayment(cardNo: String, expDate: String, cvv: String, amount: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let paymentSuccess = true
            
            if paymentSuccess {
                completion(.success(true))
            } else {
                completion(.failure(NSError(domain: "PaymentError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Payment failed"])))
            }
        }
    }
    
    func confirmPayment(otp: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let validOtp = otp == "123456"
            
            if validOtp {
                completion(.success(true))
            } else {
                completion(.failure(NSError(domain: "PaymentError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid OTP"])))
            }
        }
    }
}
