//
//  CityTests.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import XCTest
@testable import Rain_Shield

class CityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_shouldNotInitialize_givenNoCityPlacemark() {
        let placemark = PlacemarkHelper.placemark(nil)
        
        if let _ = City(placemark: placemark) {
            XCTFail()
        }
    }
    
    func test_shouldInitialize_givenCityPlacemark() {
        let placemark = PlacemarkHelper.placemark(PlacemarkHelper.defaultAddressDict)
        
        if let city = City(placemark: placemark) {
            XCTAssertEqual(city.name, "London")
        } else {
            XCTFail()
        }
    }
 
}
