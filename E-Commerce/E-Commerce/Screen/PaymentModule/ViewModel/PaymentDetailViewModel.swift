//
//  PaymentViewModel.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import Foundation

enum PaymentError: Error {
    case invalidCardNumber
    case invalidExpiryDate
    case invalidCVV
    case paymentFailed
}

final class PaymentDetailsViewModel {
    
    private(set) var cardNumber: String = ""
    private(set) var expiryDate: String = ""
    private(set) var cvv: String = ""
    private(set) var amount: String = "0.00"
    
    func updateCardNumber(_ cardNumber: String) {
        self.cardNumber = cardNumber
    }
    
    func updateExpiryDate(_ expiryDate: String) {
        self.expiryDate = expiryDate
    }
    
    func updateCVV(_ cvv: String) {
        self.cvv = cvv
    }
    
    func updateAmount(_ amount: String) {
        self.amount = amount
    }
    
    func startPayment(completion: @escaping (Result<Void, PaymentError>) -> Void) {
        // Simulate payment processing
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            // Check for valid details
            if self.cardNumber.isEmpty || self.expiryDate.isEmpty || self.cvv.isEmpty {
                completion(.failure(.paymentFailed))
            } else {
                // Simulate successful payment
                completion(.success(()))
            }
        }
    }
}
