//
//  CreateTroubleViewController.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit

class CreateTroubleViewController : UIViewController {
    
    var interactor : CreateTroubleInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor = CreateTroubleInteractor()
        interactor.delegate = self
        
    }
    
}

extension CreateTroubleViewController : CreateTroubleInteractorDelegate {
    func setCategories(_ categories: [Category]) {
        print(categories)
    }
}
