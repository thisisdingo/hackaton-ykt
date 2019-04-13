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
        
        title = "Авторизация"
        
        interactor.delegate = self
    }
    
    
    @IBAction func didAuthButtonTapped(_ sender : OCYButton){
        interactor.auth(loginTextField.text!, passwordTextField.text!)
        
    }
    
    @IBAction func didRegisterTapped(_ sender : OCYButton){
        navigationController?.pushViewController(RegisterViewController.getVC(), animated: true)
    }
    
}
extension AuthViewController : BaseInteractorDelegate {
    
    func success() {
        dismiss(animated: true, completion: nil)
    }
    
    func showError(_ message: String) {
        self.alert(message)
    }
}
