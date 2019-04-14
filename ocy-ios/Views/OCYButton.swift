//
//  OCYButton.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit

@IBDesignable class OCYButton : UIButton {
    
    private var isCornerRadiusStore = false
    @IBInspectable var isCornerRadius : Bool {
        set {
            isCornerRadiusStore = newValue
            
            if newValue {
                self.layer.cornerRadius = self.frame.height / 2
                self.layer.masksToBounds = true
            }else{
                self.layer.cornerRadius = 0
                self.layer.masksToBounds = false
            }
        }
        get {
            return isCornerRadiusStore
        }
    }
    
    func setupView() {
        self.isSkeletonable = true
        self.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.4823529412, blue: 0.831372549, alpha: 1)
    }
    
    override func didMoveToWindow() {
        setupView()
    }
    
    
    
    
    
}
