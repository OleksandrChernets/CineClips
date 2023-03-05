//
//  ProfilViewController.swift
//  CineClips
//
//  Created by Alexandr Chernets on 04.03.2023.
//

import UIKit


class ProfilViewController: UIViewController {
    
    // MARK: Detail of iOS Course
    let url = "https://development-course.notion.site/iOS-2-ec09e4e1a29542158ceb7820e337b5a2"
 
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: @IBAction
    
    @IBAction func detailButtonPressed(_ sender: Any) {
        guard let url = URL(string: url) else {
            return
        }
            UIApplication.shared.open(url)
    }
          
    @IBAction func signOutButtonPressed(_ sender: Any) {
        AuthNetworkManager.shared.logOut { responce in
            if responce.success {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let authController = storyboard.instantiateViewController(withIdentifier: "AuthControllerID")
                    self.view.window?.rootViewController = authController
                    self.view.window?.makeKeyAndVisible()
                }
            }
            
        }
    }
}



