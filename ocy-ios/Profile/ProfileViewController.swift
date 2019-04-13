//
//  ProfileViewController.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit
import SkeletonView

class ProfileViewController : UIViewController {

    @IBOutlet weak var lastnameTextField : OCYTextField!
    @IBOutlet weak var nameTextField : OCYTextField!
    @IBOutlet weak var phoneTextField : OCYTextField!
    @IBOutlet weak var streetTextField : OCYTextField!
    @IBOutlet weak var houseTextField : OCYTextField!
    @IBOutlet weak var emailTextField : OCYTextField!
    @IBOutlet weak var saveButton : OCYButton!

    var interactor = ProfileInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        interactor.fetch()
    }
    
    @IBAction func didSaveButtonTapped(_ sender : OCYButton) {
        var user = User()
        
        user.lastname = lastnameTextField.text
        user.name = nameTextField.text
        user.phone = phoneTextField.text
        user.street = streetTextField.text
        user.house = houseTextField.text
        user.email = emailTextField.text
        
        interactor.updateUserProfile(user)
    }
    
    @IBAction func didLogoutBtnTapped(_ sender : UIButton) {
        let alert = UIAlertController(title: "Внимание", message: "Вы действительно хотите выйти с аккаунта?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { _ in
            UserController.shared.dropAccessToken()
            self.tabBarController?.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)        
        
    }
    
    
}
extension ProfileViewController : BaseInteractorDelegate {
    
    func showLoading() {
        
        lastnameTextField.showAnimatedGradientSkeleton()
        nameTextField.showAnimatedGradientSkeleton()
        phoneTextField.showAnimatedGradientSkeleton()
        streetTextField.showAnimatedGradientSkeleton()
        houseTextField.showAnimatedGradientSkeleton()
        emailTextField.showAnimatedGradientSkeleton()
        saveButton.showAnimatedGradientSkeleton()
    }
    
    func hideLoading() {
        lastnameTextField.hideSkeleton()
        nameTextField.hideSkeleton()
        phoneTextField.hideSkeleton()
        streetTextField.hideSkeleton()
        houseTextField.hideSkeleton()
        emailTextField.hideSkeleton()
        saveButton.hideSkeleton()

    }
    
    func success() {
        // set user data
        let user = UserController.shared.currentUser
        
        lastnameTextField.text = user.lastname
        nameTextField.text = user.name
        phoneTextField.text = user.phone
        streetTextField.text = user.street
        houseTextField.text = user.house
        emailTextField.text = user.email
        
    }
    
    
    func showError(_ message: String) {
        alert(message)
    }
    
}
