//
//  ChooseOrderInteractor.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit
import SwiftSoup

class ChooseOrderInteractor : BaseInteractor {
    
    var orderId : String
    
    
    init(_ orderId : String ) {
        self.orderId = orderId
        
        super.init(.chooseTrouble)
    }
    
    override func fetch() {
        delegate?.showLoading?()
        api.getTrouble(orderId){ res, err in
            if let err = err {
                self.delegate?.showError?(err)
            }else{
                do {
                    let content = res as! String
                    let doc: Document = try SwiftSoup.parse(content)
                    
                    let troubles = try doc.select("#w0").select(".item").map({ return Trouble($0) })
                    (self.delegate as! MyTroublesInteractorDelegate).didFetchTroubles(troubles)
                } catch {
                    print(error.localizedDescription)
                }
                self.delegate?.hideLoading?()

            }
            self.delegate?.hideLoading?()

        }
    }
    
}
