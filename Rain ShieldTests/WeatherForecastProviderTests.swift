//
//  WeatherForecastProviderTests.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Rain_Shield

class WeatherForecastProviderTests: XCTestCase {
    
    override func tearDown() {
        HTTPStubHelper.removeAllStubs()
        super.tearDown()
    }
    
    func test_shouldProvideCorrectForecastObject_givenValidResponse() {
        HTTPStubHelper().stubForecastRequest()
        let expectation = expectationWithDescription("WeatherForecast is provided")
        
        let forecastProvider = WeatherForecastProvider.defaultProvider()
        forecastProvider.weatherForLocation(defaultLocation()) { (weatherForecast, error) -> Void in
            if let weatherForecast = weatherForecast,
                let city = weatherForecast.city
                
                where weatherForecast.items.count == 41
                && city.name == "Hoxton" {
                    
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
}

private extension WeatherForecastProviderTests {
    func defaultLocation() -> CLLocation {
        return CLLocation(latitude: 10, longitude: 10)
    }
}