//
//  User.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import Foundation
import SwiftSoup

struct User {
    var lastname : String? = nil
    var name : String? = nil
    var phone : String? = nil
    var street : String? = nil
    var house : String? = nil
    var email : String? = nil

    init() {
        
    }
    
    init(_ html : String) {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            
            lastname = try doc.select("[name=Profile[last_name]]").first()?.attr("value")
            name = try doc.select("[name=Profile[name]]").first()?.attr("value")
            phone = try doc.select("[name=Profile[phone]]").first()?.attr("value")
            street = try doc.select("[name=Profile[street]]").first()?.attr("value")
            house = try doc.select("[name=Profile[house]]").first()?.attr("value")
            email = try doc.select("[name=Profile[gravatar_email]]").first()?.attr("value")

        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var dictionary : [String : String?] {
        
        return ["Profile[gravatar_email]" : email,
                "Profile[house]" : house,
                "Profile[last_name]" : lastname,
                "Profile[middle_name]" : "",
                "Profile[name]" : name,
                "Profile[phone]" : phone,
                "Profile[street]" : street]
    }
    
}
