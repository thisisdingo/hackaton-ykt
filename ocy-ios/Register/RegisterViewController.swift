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
    
    let interactor = RegisterInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.delegate = self
        
        title = "Регистрация"
        
    }
    
    @IBAction func didRegisterTapped(_ sender : OCYButton){
        interactor.register("asdasdads@gmail.com", password: "alksasdajd", username: "aksjdaskl")
    }
    
}

extension RegisterViewController : BaseInteractorDelegate {
    
    func success() {
        
    }
    
    func showError(_ message: String) {
        self.alert(message)
    }
    
}
