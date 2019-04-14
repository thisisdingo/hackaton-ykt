//
//  MyTroubleTableViewCell.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit
import SkeletonView

class MyTroubleTableViewCell: UITableViewCell {

    @IBOutlet weak var troubleHeader : UILabel!
    @IBOutlet weak var troubleMessage : UILabel!
    @IBOutlet weak var troubleCategory : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        [troubleHeader, troubleMessage, troubleCategory].forEach {
            $0?.isSkeletonable = true
            $0?.showAnimatedGradientSkeleton()
        }
        
    }
    
    func hideSkeleton(){
        [troubleHeader, troubleMessage, troubleCategory].forEach {
            $0?.hideSkeleton()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
