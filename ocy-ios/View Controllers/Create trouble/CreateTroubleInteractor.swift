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
    
    var troubleId = ""
    
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
                
                let content = res as! String
                
                let doc: Document = try SwiftSoup.parse(content)

                let categories = try doc.select("[name=TroubleForm[category_id]]").select("option").map({ return Category($0) })
                
                
                self.troubleId = content.components(separatedBy: "media/upload?document_id=1&item_id=").last?.components(separatedBy: "\"").first ?? ""
                
                (self.delegate as! CreateTroubleInteractorDelegate).setCategories(categories)
            } catch {
                print(error.localizedDescription)
            }
            
            self.delegate?.hideLoading?()
            
        })
    }
    
    
    func uploadTrouble(_ trouble : Trouble) {
        delegate?.showLoading?()
        
        api.putTrouble(trouble, { res, err in
            self.delegate?.hideLoading?()
            self.delegate?.success?()
        })
        
    }
    
}
