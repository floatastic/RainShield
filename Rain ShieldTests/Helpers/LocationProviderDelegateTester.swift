//
//  LocationProviderDelegate.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import UIKit
import CoreLocation
@testable import Rain_Shield

class LocationProviderDelegateTester: NSObject, LocationProviderDelegate {
    
    var updatedLocation: CLLocation?
    var receivedError: NSError?
    
    func locationProvider(locationProvider: LocationProvider, didUpdateLocation location: CLLocation) {
        updatedLocation = location
    }
    
    func locationProvider(locationProvider: LocationProvider, failedToUpdateWithError error: NSError) {
        receivedError = error
    }
}
