//
//  ProfileViewModel.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

protocol ProfileViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didSignOutSuccessful()
    func didFetchUserInfo()
    func didUploadProfilePhotoSuccessful()
    func didFetchProfilePhotoSuccessful(_ url: String)
}

final class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    
    private let currentUser = Auth.auth().currentUser
    
    private let storage = Storage.storage().reference()
        
    var email: String?
    var username: String?
    
    func fetchUser() {
        if let currentUser = currentUser {
            username = currentUser.displayName
            email = currentUser.email
            self.delegate?.didFetchUserInfo()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.delegate?.didSignOutSuccessful()
        } catch {
            self.delegate?.didOccurError(error)
        }
    }
    
    func uploadImageDataToFirebaseStorage(_ imageData: Data) {
        if let currentUser = currentUser {
            let profileImageRef = storage.child("profileImages/file.png").child(currentUser.uid)
            profileImageRef.putData(imageData) { storageData, error in
                guard  error == nil else { return }
                self.delegate?.didUploadProfilePhotoSuccessful()
            }
        }
    }
    
    func fetchProfilePhoto() {
        if let currentUser = currentUser {
            let profileImageRef = storage.child("profileImages/file.png").child(currentUser.uid)
            profileImageRef.downloadURL { url, error in
                guard let url = url , error == nil else { return }
                let urlString = url.absoluteString
                self.delegate?.didFetchProfilePhotoSuccessful(urlString)
            }
        }
    }
}
