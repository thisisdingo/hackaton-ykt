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
    @objc optional func showError(_ message : String)
    @objc optional func success()
}

class BaseInteractor {
    
    let api : API!
    
    weak var delegate : BaseInteractorDelegate?
    
    init(_ route : APIRoute) {
        api = API.init(route)
        api.delegate = self
        
        delegate?.showLoading?()
    }
    
    func fetch(){}
    
    func apiInitialized(){
        
    }
    
}
extension BaseInteractor : APIDelegate {
    func showError(_ message: String) {
        delegate?.showError?(message)
    }

    func isReady() {
        delegate?.hideLoading?()
        apiInitialized()
    }
    
}
