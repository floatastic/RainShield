//
//  WeatherURLBuilderTests.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Rain_Shield

class WeatherURLBuilderTests: XCTestCase {

    func test_shouldThrow_givenNoLocation() {
        let URLBuilder = WeatherURLBuilder()
        
        var exceptionThrown = false
        
        do {
            try URLBuilder.build()
        } catch {
            exceptionThrown = true
        }
        
        XCTAssertTrue(exceptionThrown)
    }
    
    func test_shouldReturnCorrectURL() {
        let location = CLLocation(latitude: 20.0201, longitude: -30.0301)
        
        let URLBuilder = WeatherURLBuilder()
        URLBuilder.location = location
        
        let URL = try! URLBuilder.build()
        XCTAssertEqual(URL.absoluteString, "http://api.openweathermap.org/data/2.5/weather/?lat=20.0201&lon=-30.0301&APPID=7d03cbb652c57f6fde3fa54083e613d6&cnt=8")
    }

}
