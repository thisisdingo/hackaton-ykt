//
//  AuthInteractor.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import Foundation

class AuthInteractor : BaseInteractor {
    
    
    init() {
        super.init(.auth)
    }
    
    func auth(_ login : String, _ password : String){
        
        delegate?.showLoading?()
        
        api.auth(login, password, { res, err in
            if let err = err {
                self.delegate?.showError?(err)
            }else{
                self.delegate?.success?()
            }
            
            self.delegate?.hideLoading?()
        })
        
    }
    
}
