//
//  LocationProvider.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 27.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation
import CoreLocation

/**
LocationProvider guarantees to call one of it's delegate method after updateLocation() was called.
*/
protocol LocationProviderDelegate: class {
    func locationProvider(locationProvider: LocationProvider, didUpdateLocation location: CLLocation)
    
    /**
    Called in case of failure at various steps whike trying to get location.
    
    :param: locationProvider
    :param: error Will have error code as one of LocationProviderErrorCode values. Use it to figure out what went wrong
    while trying to get location
    */
    func locationProvider(locationProvider: LocationProvider, failedToUpdateWithError error: NSError)
}

enum LocationProviderErrorCode: Int {
    case NoAuthorization
    case NoLocation
}

class LocationProvider: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager
    weak var delegate: LocationProviderDelegate?
    
    class func defaultProvider() -> LocationProvider {
        return LocationProvider(locationManager: CLLocationManager())
    }
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        
        locationManager.distanceFilter = 100.0
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        super.init()
        
        locationManager.delegate = self
    }
    
    /**
    Calling this method will make LocationProvider update location only once, hence no need to call stopMonitoring()
    if one of the delegate methods was invoked.
    */
    func updateLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func stopMonitoring() {
        locationManager.stopUpdatingLocation()
    }
    
    deinit {
        stopMonitoring()
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        processAuthorizationStatus(status)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if (locations.count > 0) {
            self.delegate?.locationProvider(self, didUpdateLocation: locations.last!)
        }
        
        stopMonitoring()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        delegate?.locationProvider(self, failedToUpdateWithError: error)
        
        stopMonitoring()
    }
}

private extension LocationProvider {
    
    func processAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .AuthorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        case .Denied:
            fallthrough
        default:
            let error = NSError(domain: DefaultErrorDomain, code: LocationProviderErrorCode.NoAuthorization.rawValue, userInfo: nil)
            delegate?.locationProvider(self, failedToUpdateWithError: error)
            
        }
    }
    
}
