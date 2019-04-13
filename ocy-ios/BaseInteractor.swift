//
//  BaseInteractor.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import Foundation

@objc protocol BaseInteractorDelegate : class {
    @objc optional func showLoading()
    @objc optional func hideLoading()
}

class BaseInteractor {
    
    let api = API.init()
    
    weak var delegate : BaseInteractorDelegate?
    
    init() {
        
    }
    
}
