//
//  Helpers.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 14/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import UIKit

class Helpers {
    
    static func getNavigationController(_ rootVC : UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: rootVC)
    }
    
    
    static func compressImage(_ image : UIImage) -> Data? {
        
        var actualHeight = image.size.height
        var actualWidth = image.size.width
        
        let maxHeight : CGFloat = 2000
        let maxWidth : CGFloat = 2000
        
        
        var imgRatio = actualWidth/actualHeight
        let maxRatio = maxWidth/maxHeight
        let compressionQuality : CGFloat = 0.5
        if (actualHeight > maxHeight || actualWidth > maxWidth){
            if(imgRatio < maxRatio){
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if(imgRatio > maxRatio){
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else{
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect : CGRect = CGRect(x:0.0,y: 0.0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        
        image.draw(in: rect)
        
        let img : UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        let imageData : Data? = img.jpegData(compressionQuality: compressionQuality)
        UIGraphicsEndImageContext();
        
        return imageData
    }
    
}
