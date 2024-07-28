//
//  ProfileView.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 28.07.2024.
//

import UIKit

protocol ProfileViewInterface: AnyObject {
    func profileView(_ view: ProfileView, signOutButtonTapped button: UIButton)
    func profileView(_ view: ProfileView, addProfileButtonTapped button: UIButton)
    func profileView(_ view: ProfileView, resetPasswordButtonTapped button: UIButton)
}

final class ProfileView: UIView {
    
    // MARK: - Creating UI Elements
    
    var profileImageView = CustomImageView(image: UIImage(systemName: "person.circle")!, tintColor: .systemBlue, backgroundColor: .clear, contentMode: .scaleToFill, maskedToBounds: true, cornerRadius: 50, isUserInteractionEnabled: false)
    private var userNameLabel = CustomLabel(text: "@username", numberOfLines: 1, font: .boldSystemFont(ofSize: 22), textColor: .black, textAlignment: .center)
    private var emailLabel = CustomLabel(text: "email@example.com", numberOfLines: 1, font: .systemFont(ofSize: 16), textColor: .darkGray, textAlignment: .center)
    private var addProfilePhotoButton = CustomButton(title: "Upload Profile Photo", titleColor: .white, backgroundColor: .systemGreen, cornerRadius: 10)
    private var resetPasswordButton = CustomButton(title: "Change Password", titleColor: .white, backgroundColor: .systemRed, cornerRadius: 10)
    private var signOutButton = CustomButton(title: "Sign Out", titleColor: .white, backgroundColor: .systemGray, cornerRadius: 10)
    
    // MARK: - Properties
    
    weak var interface: ProfileViewInterface?
    
    // MARK: - Init methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview()
        setupConstraints()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(email: String, username: String) {
        userNameLabel.text = "@\(username)"
        emailLabel.text = email
    }
    
    // MARK: - AddTarget
    
    private func addTarget() {
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        addProfilePhotoButton.addTarget(self, action: #selector(addProfileButtonTapped), for: .touchUpInside)
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - AddAction
    
    @objc private func addProfileButtonTapped(_ button: UIButton) {
        interface?.profileView(self, addProfileButtonTapped: button)
    }
    
    @objc private func resetPasswordButtonTapped(_ button: UIButton) {
        interface?.profileView(self, resetPasswordButtonTapped: button)
    }
    
    @objc private func signOutButtonTapped(_ button: UIButton) {
        interface?.profileView(self, signOutButtonTapped: button)
    }
    
}

// MARK: - UI Elements AddSubview / Constraints

extension ProfileView {
    
    // MARK: - AddSubview
    
    private func addSubview() {
        addSubviews(profileImageView, userNameLabel, emailLabel, addProfilePhotoButton, resetPasswordButton, signOutButton)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
        }
        userNameLabel.sizeToFit()
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        emailLabel.sizeToFit()
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        addProfilePhotoButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        resetPasswordButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(addProfilePhotoButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
