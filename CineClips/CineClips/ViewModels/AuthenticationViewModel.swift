//
//  AuthenticationViewModel.swift
//  CineClips
//
//  Created by Alexandr Chernets on 30.01.2023.
//

import Foundation

class AuthenticationViewModel {
    
    // MARK: isLogin toggle
    var isLogin = false
    
    // MARK: - Create user session
    func signInTapped( _ userName: String, _ password: String, _ completionHandler: @escaping (() -> Void)) {
        guard !userName.isEmpty,
              !password.isEmpty else {
            print("error")
            return
        }
        AuthNetworkManager.shared.makeMultiRequest(username: userName, password: password) { [weak self] success in
            guard let self = self else { return }
            self.isLogin = success
            completionHandler()
        }
        
    }
    // MARK: Create guest session
    func guestSignInTapped(_ completionHandler: @escaping (() -> Void)) {
        AuthNetworkManager.shared.guestSession({ [weak self] guestSession in
            guard let self = self else { return }
            self.isLogin = guestSession.success
            completionHandler()
        })
        
    }
    
}
