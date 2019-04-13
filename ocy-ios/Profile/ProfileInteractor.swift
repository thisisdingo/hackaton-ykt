//
//  ProfileInteractor.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import Foundation

class ProfileInteractor : BaseInteractor {
    
    init() {
        super.init(.profile)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userFetched), name: Constants.userConfigLoadedNotification, object: nil)
    }
    
    override func fetch() {
        super.fetch()
        
        delegate?.showLoading?()
        
        UserController.shared.checkUser()
    }
    
    func updateUserProfile(_ profile : User){
        api.updateProfile(profile, { [weak self] res, _ in
            self?.fetch()
        })
    }
    
    @objc private func userFetched(){
        if UserController.shared.isAuth {
            delegate?.success?()
        }else{
            // Logout
            UserController.shared.dropAccessToken()
        }
        
        delegate?.hideLoading?()
    }
}
