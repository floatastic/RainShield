//
//  PlacemarkHelper.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import CoreLocation
import AddressBook
import MapKit

class PlacemarkHelper: NSObject {
    
    private static let defaultCoordinate = CLLocationCoordinate2D(latitude: 10, longitude: 20)
    
    class func placemark(addressDict: [String : String]?) -> CLPlacemark {
        return MKPlacemark(coordinate: defaultCoordinate, addressDictionary: addressDict)
    }
    
    class func addressDictionary(cityName cityName: String?, countryCode: String?) -> [String : String] {
        var dictionary = [String : String]()
        
        if let cityName = cityName {
            dictionary[String(kABPersonAddressCityKey)] = cityName
        }
        if let countryCode = countryCode {
            dictionary[String(kABPersonAddressCountryCodeKey)] = countryCode
        }
        
        return dictionary
    }
    
    class func defaultAddressDictionary() -> [String : String] {
        return addressDictionary(cityName: "London", countryCode: "UK")
    }
}
