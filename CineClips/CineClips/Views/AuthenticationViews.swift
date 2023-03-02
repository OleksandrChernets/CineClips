//
//  AuthenticationViews.swift
//  CineClips
//
//  Created by Alexandr Chernets on 30.01.2023.
//

import Foundation

import UIKit

class AuthenticationViewController: UIViewController {
    lazy var authenticationViewModel = AuthenticationViewModel()
    
    @IBOutlet weak var loginImage: UIImageView! {
        didSet {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = loginImage.bounds
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
            
            loginImage.layer.addSublayer(gradientLayer)
            loginImage.layer.mask = gradientLayer
        }
    }
    
    @IBOutlet weak var errorTextLabel: UILabel! {
        didSet {
            errorTextLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var userNameTextField: UITextField! {
        didSet {
            userNameTextField.delegate = self
            
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
            passwordTextField.isSecureTextEntry = true
            passwordTextField.textContentType = .oneTimeCode
        }
    }
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var guestInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Check authentication result and make root VC
    func bindAuthentication() {
        if authenticationViewModel.isLogin {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let firstNavigationController = storyboard.instantiateViewController(withIdentifier: "firstNavControllerId")
                self.view.window?.rootViewController = firstNavigationController
                self.view.window?.makeKeyAndVisible()
            }
            
        }
    }
    // MARK: - Sign In button action
    @IBAction func signInTapped(_ sender: UIButton) {
        authenticationViewModel.signInTapped(userNameTextField.text ?? "", passwordTextField.text ?? "") {
            self.bindAuthentication()
        }
        
    }
    // MARK: - Guest In button action
    @IBAction func guestSignInTapped(_ sender: UIButton) {
        authenticationViewModel.guestSignInTapped {
            self.bindAuthentication()
        }
        
    }
    // MARK: - Configure UI
    private func setupUI() {
        // MARK: - Configure gueastInButton
        let guestButtonTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
            string: "Sign in as a Guest",
            attributes: guestButtonTextAttributes
        )
        guestInButton.setAttributedTitle(attributeString, for: .normal)
    }
    
}
// MARK: - Check textfields are empties, update UI
extension AuthenticationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let usernameText = userNameTextField.text,
           let passwordText = passwordTextField.text,
           !usernameText.isEmpty,
           !passwordText.isEmpty    {
            
        }
        
        return true
    }
    
}
