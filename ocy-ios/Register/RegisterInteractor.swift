//
//  RegisterInteractor.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import Foundation

class RegisterInteractor : BaseInteractor {
    
    init() {
        super.init(.register)
    }
    
    func register(_ email : String, password : String, username : String){
        api.register(email, password: password, username: username, { json, err in
            if let err = err {
                self.delegate?.showError?(err)
            }else{
                self.delegate?.success?()
            }
        })
    }
    
}
