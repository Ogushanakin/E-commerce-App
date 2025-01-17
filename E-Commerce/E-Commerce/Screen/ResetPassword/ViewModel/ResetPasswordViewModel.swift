//
//  ResetPasswordViewModel.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import Foundation
import FirebaseAuth

protocol ResetPasswordViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didResetPasswordSuccessful()
}

final class ResetPasswordViewModel {
    
    //MARK: - Properties
    
    weak var delegate: ResetPasswordViewModelDelegate?
    
    func resetPassword(_ email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.delegate?.didOccurError(error)
            } else {
                self.delegate?.didResetPasswordSuccessful()
            }
        }
    }
}
