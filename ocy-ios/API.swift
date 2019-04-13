//
//  API.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import Indigear
import SwiftyJSON

typealias callback = (_ result : JSON) -> Void


protocol APIDelegate : class {
    func showError(_ message : String)
}

class API {
    
    weak var delegate : APIDelegate?
    
    var headers : [String : String] {
        return ["Origin" : "https://www.oneclickyakutsk.ru",
                "Upgrade-Insecure-Requests" : "1",
                "Content-Type" : "application/x-www-form-urlencoded",
                "User-Agent" : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36",
                "Accept" : "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3",]
    }
    
    var csrfToken : String = ""
    
    init() {
        getCSFRToken()
    }
    
    func getCSFRToken(){
        let strongSelf = self
        Indigear.run("https://www.oneclickyakutsk.ru/", { [weak self] result in
            
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
                       "register-form[login]" : "\(email)",
                       "register-form[password]" : password,
                       "register-form[username]" : username]
        
        Indigear.post(Constants.serverAddress + "user/register", headers, params, { result in
            print(String(data: result.result!, encoding : .utf8)!)
        })
    }
    
    //func auth(_ )
    
}
