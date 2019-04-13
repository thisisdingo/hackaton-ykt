//
//  OCYTextField.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit
import SkeletonView

@IBDesignable class OCYTextField : UITextField {
    
    func setupView() {
        self.isSkeletonable = true
        borderStyle = .roundedRect
        
        let toolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onToolBarDone))
        
        toolbar.items = [space, doneBtn]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    @objc func onToolBarDone() {
        self.endEditing(true)
    }
    
    override func didMoveToWindow() {
        setupView()
    }
    
    
}
