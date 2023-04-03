//
//  AuthenticationViews.swift
//  CineClips
//
//  Created by Alexandr Chernets on 30.01.2023.
//

import Foundation

import UIKit

final class AuthenticationViewController: UIViewController {
    
    //MARK: @IBOutlets
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var guestInButton: UIButton!
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
    
    //MARK: Properties
    lazy var authenticationViewModel = AuthenticationViewModel()
    
    //MARK: Lifecycle Methods
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
    
    //MARK: @IBActions
    //Sign In button action
    @IBAction func signInTapped(_ sender: UIButton) {
        authenticationViewModel.signInTapped(userNameTextField.text ?? "", passwordTextField.text ?? "") {
            self.bindAuthentication()
        }
        
    }
    
    //Guest In button action
    @IBAction func guestSignInTapped(_ sender: UIButton) {
        authenticationViewModel.guestSignInTapped {
            self.bindAuthentication()
        }
    }
    
    // MARK: - Configure UI
    private func setupUI() {
        //Configure gueastInButton
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
        
        guard let usernameText = userNameTextField.text, !usernameText.isEmpty,
              let passwordText = passwordTextField.text, !passwordText.isEmpty else {
            return true
        }
        // Code to execute when both fields are not empty
        return true
    }
}
