//
//  City.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation
import CoreLocation
import AddressBook

struct City {
    let name: String
    
    init?(placemark: CLPlacemark) {
        guard let cityName = placemark.addressDictionary?[kABPersonAddressCityKey] as? String else {
            return nil
        }
        
        name = cityName
    }
}
