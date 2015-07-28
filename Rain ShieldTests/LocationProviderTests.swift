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
    var locationProvider: LocationProvider?
    var delegateTester: LocationProviderDelegateTester?
    
    override func setUp() {
        super.setUp()
        
        locationManagerMock = LocationManagerMock()
        locationProvider = LocationProvider(locationManager: locationManagerMock!)
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
    
    func test_shouldPassLocationToDelegate_givenPlacemark() {
        locationManagerMock!.simulateLocationUpdate()
        
        XCTAssertNil(delegateTester!.receivedError)
        XCTAssertNotNil(delegateTester!.updatedLocation)
    }
    
}
