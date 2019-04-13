//
//  AuthViewController.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit
import AutoKeyboard

class AuthViewController : UIViewController {

    @IBOutlet weak var loginTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var loginButton : OCYButton!

    var interactor : AuthInteractor!
    
    static func getVC() -> AuthViewController {
        return AuthViewController(nibName: "AuthViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Авторизация"
        
        interactor = AuthInteractor.init()
        interactor.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerAutoKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unRegisterAutoKeyboard()
    }
    
    @IBAction func didAuthButtonTapped(_ sender : OCYButton){
        interactor.auth(loginTextField.text!, passwordTextField.text!)
        
    }
    
    @IBAction func didRegisterTapped(_ sender : OCYButton){
        navigationController?.pushViewController(RegisterViewController.getVC(), animated: true)
    }
    
}
extension AuthViewController : BaseInteractorDelegate {
    
    func showLoading() {
        loginButton.showAnimatedGradientSkeleton()
    }
    
    
    func hideLoading() {
        loginButton.hideSkeleton()

    }
    
    func success() {
        dismiss(animated: true, completion: nil)
    }
    
    func showError(_ message: String) {
        self.alert(message)
    }
}
