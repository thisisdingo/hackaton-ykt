//
//  RegisterViewController.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit

class RegisterViewController : UIViewController {
    
    static func getVC() -> RegisterViewController {
        return RegisterViewController(nibName: "RegisterViewController", bundle: nil)
    }
    
    var interactor : RegisterInteractor!
    
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var loginTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var registerButton : OCYButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor = RegisterInteractor()
        interactor.delegate = self
        
        title = "Регистрация"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerAutoKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unRegisterAutoKeyboard()
    }
    
    @IBAction func didRegisterTapped(_ sender : OCYButton){
        interactor.register(emailTextField.text!, password: passwordTextField.text!, username: loginTextField.text!)
    }
    
}

extension RegisterViewController : BaseInteractorDelegate {
    
    func showLoading() {
        registerButton.showAnimatedGradientSkeleton()
    }
    
    func hideLoading() {
        registerButton.hideSkeleton()
    }
    
    
    func success() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func showError(_ message: String) {
        self.alert(message)
    }
    
}
