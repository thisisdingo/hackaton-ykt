//
//  IntroViewController.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit

class IntroViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.configLoaded), name: Constants.userConfigLoadedNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserController.shared.checkUser()
    }
    
    @objc func configLoaded(){
        if UserController.shared.isAuth {
            present(MainTabBar.getVC(), animated: true, completion: nil)
        }else{
            present(AuthViewController.getVC(), animated: true, completion: nil)
        }
    }
    
}
