//
//  LocationProviderDelegate.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import UIKit
@testable import Rain_Shield

class LocationProviderDelegateTester: NSObject, LocationProviderDelegate {
    
    var updatedCity: City?
    var receivedError: NSError?
    
    func locationProvider(locationProvider: LocationProvider, didUpdateCity city: City) {
        updatedCity = city
    }
    
    func locationProvider(locationProvider: LocationProvider, failedToUpdateWithError error: NSError) {
        receivedError = error
    }
}
