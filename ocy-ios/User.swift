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
    var middlename : String? = nil
    var phone : String? = nil
    var street : String? = nil
    var house : String? = nil
    var email : String? = nil

    init() {
        
    }
    
    init(_ html : String) {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            
            lastname = try doc.select("#profile-last_name").first()?.attr("value")
            name = try doc.select("#profile-name").first()?.attr("value")
            middlename = try doc.select("#profile-middle_name").first()?.attr("value")
            phone = try doc.select("#profile-phone").first()?.attr("value")
            street = try doc.select("#profile-street").first()?.attr("value")
            house = try doc.select("#profile-house").first()?.attr("value")
            email = try doc.select("#profile-gravatar_email").first()?.attr("value")

        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
