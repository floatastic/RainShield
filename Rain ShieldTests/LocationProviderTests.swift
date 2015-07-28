//
//  LocationProviderTests.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import XCTest
@testable import Rain_Shield

import CoreLocation

class LocationProviderTests: XCTestCase {
    
    var locationManagerMock: LocationManagerMock?
    var geocoderMock: GeocoderMock?
    var locationProvider: LocationProvider?
    var delegateTester: LocationProviderDelegateTester?
    
    override func setUp() {
        super.setUp()
        
        locationManagerMock = LocationManagerMock()
        geocoderMock = GeocoderMock()
        locationProvider = LocationProvider(locationManager: locationManagerMock!, geocoder: geocoderMock!)
        delegateTester = LocationProviderDelegateTester()
        locationProvider!.delegate = delegateTester
    }
    
    override func tearDown() {
        locationManagerMock = nil
        locationProvider = nil
        
        super.tearDown()
    }
    
    func test_shouldRequirePermissions() {
        locationProvider!.updateLocation()
        XCTAssertTrue(locationManagerMock!.requestWhenInUseCalled)
    }
    
    func test_shouldConfigureProviderAtInit() {
        XCTAssertTrue(locationManagerMock!.delegate! === locationProvider!)
        XCTAssertEqual(locationManagerMock!.desiredAccuracy, kCLLocationAccuracyHundredMeters)
        XCTAssertEqualWithAccuracy(locationManagerMock!.distanceFilter, 100.0, accuracy: 0.1)
    }
    
    func test_shouldConfigureDefaultProvider() {
        XCTAssertTrue(locationProvider!.locationManager === locationManagerMock!)
        XCTAssertTrue(locationProvider!.geocoder === geocoderMock!)
    }
    
    func test_shouldStopUpdatingLocation() {
        locationManagerMock!.isUpdatingLocation = true
        locationProvider!.stopMonitoring()
        
        XCTAssertFalse(locationManagerMock!.isUpdatingLocation)
    }
    
    func test_shouldUpdateLocation_whenAuthorized() {
        locationManagerMock!.simulateStatusChange(.AuthorizedWhenInUse)
        
        XCTAssertTrue(locationManagerMock!.isUpdatingLocation)
    }
    
    func test_shouldReturnError_whenNotAuthorized() {
        locationManagerMock!.simulateStatusChange(.Denied)
        
        XCTAssertNotNil(delegateTester!.receivedError)
        XCTAssertEqual(delegateTester!.receivedError!.code, LocationProviderErrorCode.NoAuthorization.rawValue)
    }
    
    func test_shouldPassCityToDelegate_givenPlacemark() {
        locationManagerMock!.simulateLocationUpdate()
        
        XCTAssertNil(delegateTester!.receivedError)
        XCTAssertTrue(delegateTester!.updatedCity != nil)
    }
    
    func test_shouldPassErrorToDelegate_givenGeocoderError() {
        geocoderMock!.simulateError = true
        
        locationManagerMock!.simulateLocationUpdate()
        
        XCTAssertNotNil(delegateTester!.receivedError)
        XCTAssertEqual(delegateTester!.receivedError!.code, LocationProviderErrorCode.NoCity.rawValue)
        XCTAssertTrue(delegateTester!.updatedCity == nil)
    }
}
