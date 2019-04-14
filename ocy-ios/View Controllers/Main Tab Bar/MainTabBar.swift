//
//  MainTabBar.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit

class MainTabBar : UITabBarController {
    
    static func getVC() -> MainTabBar {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setUserData), name: Constants.userProfileUpdated, object: nil)
    }
    
    @objc func setUserData(){
        //tabBar.items?.last?.title = UserController.shared.currentUser.name
    }
    
}
