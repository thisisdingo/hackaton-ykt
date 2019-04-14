//
//  Trouble.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit
import SwiftSoup

struct Trouble {
    
    var id : String = ""
    var phone : String = ""
    var header : String = ""
    var message : String = ""
    var category : Category? = nil
    var address : String = ""
    var room : String = ""
    var porch : String = ""
    var latitude : String = ""
    var longitude : String = ""
    var attachImages = [UIImage]()
    
    init(){}
    
    init(_ element : Element) {
        do {
            
            header = try element.select(".top-area").select("h3").text()
            message = try element.select(".top-area").select("p").text()
            category = Category()
            
            let link = try element.select("a").attr("href")
            
            self.id = String(link.split(separator: "=").last ?? "")
            
            let title = try element.select(".bottom-area").select(".category").text()
            category?.title = title.replacingOccurrences(of: "Категория: ", with: "")

        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    var dictionary : [String : String] {
        return ["TroubleForm[phone]" : phone,
                "TroubleForm[header]" : header,
                "TroubleForm[latitude]" : latitude,
                "TroubleForm[longitude]" : longitude,
                "TroubleForm[message]" : message,
                "TroubleForm[address]" : address,
                "TroubleForm[porch]" : porch,
                "TroubleForm[room]" : room,
                "TroubleForm[category_id]" : category?.id ?? "",
                "Attachment[uploadedFile]" : ""]
    }
    
}
