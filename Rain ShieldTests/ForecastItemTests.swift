//
//  ForecastItemTests.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import XCTest
@testable import Rain_Shield

class ForecastItemTests: XCTestCase {

    func test_shouldHaveRainyCode() {
        let item0 = ForecastItem(timestamp: nil, weatherCodeRaw: WeatherCode.Rain.rawValue, icon: nil)
        let item1 = ForecastItem(timestamp: nil, weatherCodeRaw: 560, icon: nil)
        
        XCTAssert(item0.isWeatherCodeRain())
        XCTAssert(item1.isWeatherCodeRain())
    }

    func test_shouldNotHaveRainyCode() {
        let item0 = ForecastItem(timestamp: nil, weatherCodeRaw: nil, icon: nil)
        let item1 = ForecastItem(timestamp: nil, weatherCodeRaw: 100, icon: nil)
        let item2 = ForecastItem(timestamp: nil, weatherCodeRaw: WeatherCode.Snow.rawValue, icon: nil)
        
        XCTAssertFalse(item0.isWeatherCodeRain())
        XCTAssertFalse(item1.isWeatherCodeRain())
        XCTAssertFalse(item2.isWeatherCodeRain())
    }
    
}
