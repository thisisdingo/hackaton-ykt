//
//  UserController.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import Foundation

class UserController {
    
    static let shared : UserController = UserController.init()
    
    var api = API(.none)
    
    private var isAuthStorage : Bool = false
    var isAuth : Bool {
        set (value) {
            isAuthStorage = value
            
            if value {
                fetchUser()
            }
        }
        get {
            return isAuthStorage
        }
    }
    var configLoaded : Bool = false
    
    var currentUser = User()
    
    func checkUser(){
        api.isAuth({ [weak self] result, err in
            self?.isAuth = (result as? Bool) ?? false
            self?.configLoaded = true

            NotificationCenter.default.post(name: Constants.userConfigLoadedNotification, object: nil)
        })
    }
    
    func fetchUser(){
        api.fetchUser({ html, error in
            if let err = error {
                print(err)
                return
            }
            
            self.currentUser = User((html as? String) ?? "")
            NotificationCenter.default.post(name: Constants.userProfileUpdated, object: nil)
        })
    }
    
}
