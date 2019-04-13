//
//  DOMParser.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import Foundation
import SwiftSoup

class DOMParser {
    
    static func getError(_ html : String) -> String{
        
        var info = String()
        do {
            let doc: Document = try SwiftSoup.parse(html)
            
            // Пздц
            let text: Element? = try doc.select(".has-error").select(".help-block").first()
            
            info = try text?.text() ?? ""
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
        
        
        return info
    }
    
}
