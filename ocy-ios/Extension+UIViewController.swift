//
//  Extension+UIViewController.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    func alert(_ text : String){
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)        
    }
}
