//
//  LocationProvider.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 27.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation
import CoreLocation

struct City {
    let name: String
    
    init(placemark: CLPlacemark) {
        name = "London"
    }
}

/**
LocationProvider guarantees to call one of it's delegate method after updateLocation() was called.
*/
protocol LocationProviderDelegate: class {
    func locationProvider(locationProvider: LocationProvider, didUpdateCity city: City)
    
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
    case NoCity
}

class LocationProvider: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager
    var geocoder: CLGeocoder
    weak var delegate: LocationProviderDelegate?
    
    class func defaultProvider() -> LocationProvider {
        return LocationProvider(locationManager: CLLocationManager(), geocoder: CLGeocoder())
    }
    
    init(locationManager: CLLocationManager, geocoder: CLGeocoder) {
        self.locationManager = locationManager
        self.geocoder = geocoder
        
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
            processLocationUpdate(locations.last!)
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
    
    func processLocationUpdate(newLocation: CLLocation) {
        geocoder.reverseGeocodeLocation(newLocation) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            
            if let placemark = placemarks?.first {
                let city = City(placemark: placemark)
                self.delegate?.locationProvider(self, didUpdateCity: city)
            } else {
                let error = NSError(domain: DefaultErrorDomain, code: LocationProviderErrorCode.NoCity.rawValue, userInfo: nil)
                self.delegate?.locationProvider(self, failedToUpdateWithError: error)
            }
        }
    }
}
