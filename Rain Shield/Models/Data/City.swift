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
    var countryCode: String? = nil
    
    init?(placemark: CLPlacemark) {
        let addressDictionary = placemark.addressDictionary
        
        guard let cityName = addressDictionary?[kABPersonAddressCityKey] as? String else {
            return nil
        }
        
        name = cityName
        
        if let countryCode = addressDictionary?[kABPersonAddressCountryCodeKey] as? String {
            self.countryCode = countryCode
        }
    }
}
