//
//  ViewController.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        present(AuthViewController.getVC(), animated: true, completion: nil)
    }
}

