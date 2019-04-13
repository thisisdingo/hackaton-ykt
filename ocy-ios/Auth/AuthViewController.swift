//
//  AuthViewController.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit

class AuthViewController : UIViewController {

    @IBOutlet weak var loginTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    
    let interactor : AuthInteractor = AuthInteractor.init()
    
    static func getVC() -> AuthViewController {
        return AuthViewController(nibName: "AuthViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.delegate = self
    }
    
    
    @IBAction func didAuthButtonTapped(_ sender : OCYButton){
        interactor.auth(loginTextField.text!, passwordTextField.text!)
        
    }
    
}
extension AuthViewController : BaseInteractorDelegate {
    
    func success() {
        
    }
    
    func showError(_ message: String) {
        self.alert(message)
    }
}
