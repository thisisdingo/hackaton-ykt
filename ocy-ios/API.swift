//
//  API.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import Indigear
import SwiftyJSON

typealias callback = (_ result : JSON, _ err : String?) -> Void


protocol APIDelegate : class {
    func isReady()
    func showError(_ message : String)
}

enum APIRoute : String {
    case none = ""
    case register = "user/register"
    case auth = "user/login"
}

class API {
    
    static func getJSON(_ data : Data?) -> JSON {
        return JSON(data ?? Data())
    }
    
    weak var delegate : APIDelegate?
    
    var route : APIRoute!
    
    var headers : [String : String] {
        var content = ["Origin" : "https://www.oneclickyakutsk.ru",
                "Upgrade-Insecure-Requests" : "1",
                "Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8",
                "User-Agent" : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36",
                "Accept" : "application/json, text/javascript, */*; q=0.01"]
        
        
        if !csrfToken.isEmpty {
            content["X-CSRF-Token"] = csrfToken
        }
        
        return content
    }
    
    var csrfToken : String = "" {
        didSet (value) {
            if !value.isEmpty {
                delegate?.isReady()
            }
        }
    }
    
    init(_ route : APIRoute) {
        self.route = route
        getCSFRToken()
    }
    
    func getCSFRToken(){
        let strongSelf = self
        
        let url = "https://www.oneclickyakutsk.ru/" + route.rawValue

        print("CSRF Token url: ", url)
        
        Indigear.run(url, { [weak self] result in
            
            guard let weakSelf = self else {
                return
            }
            
            if let err = result.error {
                strongSelf.delegate?.showError(err.localizedDescription)
                return
            }
            
            let content = String(data: result.result!, encoding: .utf8)
            
            
            let token = content?.components(separatedBy: "meta name=\"csrf-token\" content=\"").last?.components(separatedBy: "\">").first
            
            weakSelf.csrfToken = token ?? ""
        })
    }
    
    func register(_ email : String, password : String, username : String, _ c : @escaping callback){
        let params = ["_csrf-frontend" : csrfToken,
                       "register-form[email]" : email,
                       "register-form[login]" : "",
                       "register-form[password]" : password,
                       "register-form[username]" : username]
        
        Indigear.post(Constants.serverAddress + "user/register", headers, params, { result in
            
            let errorString = DOMParser.getError(String(data: result.result!, encoding : .utf8)!)
            
            var error : String? = nil
            
            if !errorString.isEmpty {
                error = errorString
            }
            
            c(API.getJSON(result.result), error)
        })
    }
    
    func auth(_ login : String, _ password : String, _ c : @escaping callback) {
        
        let params = ["_csrf-frontend" : csrfToken,
                      "ajax" : "login-form",
                      "login-form[login]" : login,
                      "login-form[password]" : password,
                      "login-form[rememberMe]" : "1"]
        
        Indigear.post(Constants.serverAddress + "user/login", headers, params, { result in
            
            
            if let err = result.error {
                c(JSON(), err.localizedDescription)
                return
            }
            
            let errorString = DOMParser.getError(String(data: result.result ?? Data(), encoding : .utf8)!)
            
            
            
            var error : String? = nil
            
            if !errorString.isEmpty {
                error = errorString
            }
            c(JSON(), error)
        })
        
    }
    
}
