//
//  GeocoderMock.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import UIKit
import CoreLocation

class GeocoderMock: CLGeocoder {
    
    var simulateError = false
    var placemark: CLPlacemark = PlacemarkHelper.placemark(PlacemarkHelper.defaultAddressDictionary())
    
    override func reverseGeocodeLocation(location: CLLocation, completionHandler: CLGeocodeCompletionHandler) {
        
        if simulateError {
            let error = NSError(domain: "", code: CLError.GeocodeFoundNoResult.rawValue, userInfo: nil)
            completionHandler(nil, error)
        } else {
            completionHandler([placemark], nil)
        }
        
    }
}
