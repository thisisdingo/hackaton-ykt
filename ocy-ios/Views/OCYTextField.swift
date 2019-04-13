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
        borderStyle = .none
        
        var newFrame = frame
        newFrame.size.height = 44.0
        self.frame = newFrame
        layoutSubviews()
    }
    
    override func didMoveToWindow() {
        setupView()
    }
    
    
}
