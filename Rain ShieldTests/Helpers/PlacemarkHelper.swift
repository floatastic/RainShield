//
//  PlacemarkHelper.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import CoreLocation
import MapKit

class PlacemarkHelper: NSObject {
    
    static let defaultAddressDict: [String : String] = ["City" : "London"]
    
    class func placemark(addressDict: [String : String]?) -> CLPlacemark {
        
        return MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 20), addressDictionary: addressDict)
        
    }
}
