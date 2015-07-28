//
//  WeatherURLBuilderTests.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import XCTest
@testable import Rain_Shield

class WeatherURLBuilderTests: XCTestCase {

    func test_shouldThrow_givenCityWithoutName() {
        let city = emptyNameCity()
        let URLBuilder = WeatherURLBuilder()
        URLBuilder.cityName = city.name
        
        var exceptionThrown = false
        
        do {
            try URLBuilder.build()
        } catch {
            exceptionThrown = true
        }
        
        XCTAssertTrue(exceptionThrown)
    }
    
    func test_shouldReturnCorrectURL() {
        let placemark = PlacemarkHelper.placemark(PlacemarkHelper.defaultAddressDictionary())
        let city = City(placemark: placemark)
        
        let URLBuilder = WeatherURLBuilder()
        URLBuilder.cityName = city!.name
        URLBuilder.countryCode = city!.countryCode
        
        let URL = try! URLBuilder.build()
        XCTAssertEqual(URL.absoluteString, "http://api.openweathermap.org/data/2.5/weather/?q=London,UK&APPID=7d03cbb652c57f6fde3fa54083e613d6")
    }
    
    private func emptyNameCity() -> City {
        let addressDictionary = PlacemarkHelper.addressDictionary(cityName: "", countryCode: "")
        let placemark = PlacemarkHelper.placemark(addressDictionary)
        return City(placemark: placemark)!
    }

}
