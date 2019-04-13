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
    
    var isAuth : Bool = false
    var configLoaded : Bool = false
    
    func checkUser(){
        api.isAuth({ [weak self] result, err in
            guard result as! Bool else {
                return
            }
            
            self?.isAuth = result as! Bool
            self?.configLoaded = true

            NotificationCenter.default.post(name: Constants.userConfigLoadedNotification, object: nil)
        })
    }
    
}
