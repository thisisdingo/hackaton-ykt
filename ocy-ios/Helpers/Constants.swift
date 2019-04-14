//
//  Constants.swift
//  ocy-ios
//
//  Created by Mister Gamburger on 13/04/2019.
//  Copyright © 2019 devyat. All rights reserved.
//

import Foundation

struct Constants {
    static let serverAddress = "https://www.oneclickyakutsk.ru/"
    static let osm_url = "https://nominatim.openstreetmap.org/reverse?format=json&addressdetails=1&accept-language=ru&"

    
    static let userConfigLoadedNotification = Notification.Name("userConfigLoadedNotification")
    static let userProfileUpdated = Notification.Name("userProfileUpdated")
    
}
