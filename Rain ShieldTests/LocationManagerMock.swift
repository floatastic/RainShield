//
//  CLLocationManagerMock.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManagerMock: CLLocationManager {
    
    var isUpdatingLocation = false
    
    var requestWhenInUseCalled = false
    
    var discoveredlocation = CLLocation(latitude: 20.0, longitude: 30.0)
    
    override func requestWhenInUseAuthorization() {
        requestWhenInUseCalled = true
    }
    
    override func startUpdatingLocation() {
        isUpdatingLocation = true
    }
    
    override func stopUpdatingLocation() {
        isUpdatingLocation = false
    }
    
    func simulateStatusChange(status: CLAuthorizationStatus) {
        self.delegate?.locationManager!(self, didChangeAuthorizationStatus: status)
    }
    
    func simulateNetworkError() {
        let error = NSError(domain: "", code: CLError.Network.rawValue, userInfo: nil)
        self.delegate?.locationManager!(self, didFailWithError: error)
    }
    
    func simulateLocationUpdate() {
        self.delegate?.locationManager!(self, didUpdateLocations: [discoveredlocation])
    }
    
}
