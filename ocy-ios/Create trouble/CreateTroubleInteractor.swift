//
//  CreateTroubleInteractor.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import Foundation
import SwiftSoup

protocol CreateTroubleInteractorDelegate : BaseInteractorDelegate {
    func setCategories(_ categories : [Category])
}

class CreateTroubleInteractor : BaseInteractor {
    
    init() {
        super.init(.createTrouble)
    }
    
    override func apiInitialized() {
        super.apiInitialized()
        
        self.fetch()
    }
    
    override func fetch() {
        super.fetch()
        
        delegate?.showLoading?()
        
        api.fetchCategories({ res, err in
            
            do {
                let doc: Document = try SwiftSoup.parse(res as! String)

                let categories = try doc.select("[name=TroubleForm[category_id]]").select("option").map({ return Category($0) })
                
                (self.delegate as! CreateTroubleInteractorDelegate).setCategories(categories)
            } catch {
                print(error.localizedDescription)
            }
            
        })
    }
    
    
}
