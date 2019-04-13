//
//  Category.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import Foundation
import SwiftSoup

struct Category {
    
    var id : String = ""
    var title : String = ""
    
    init() {
    }
    
    init(_ element : Element) {
        do {
            id = try element.attr("value")
            title = try element.text()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
