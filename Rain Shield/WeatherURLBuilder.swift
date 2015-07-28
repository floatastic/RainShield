//
//  WeatherURLBuilder.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation

enum WeatherURLBuilderError: ErrorType {
    case NoCityName
}

class WeatherURLBuilder: NSObject {
    
    private let AppID = "7d03cbb652c57f6fde3fa54083e613d6"
    private let scheme = "http"
    private let host = "api.openweathermap.org"
    private let path = "/data/2.5/weather/"
    private let weatherParamName = "q"
    private let appParamName = "APPID"
    
    var cityName: String?
    var countryCode: String?
    
    func build() throws -> NSURL {
        var query = try cityQueryPart()
        query += "&" + appParamName + "=" + AppID
        
        let components = NSURLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.query = query
        
        return components.URL!
    }
    
    func cityQueryPart() throws -> String {
        
        guard let cityName = cityName where cityName.characters.count > 0 else {
            throw WeatherURLBuilderError.NoCityName
        }
        
        var cityQuery = weatherParamName + "=" + cityName
        
        if let countryCode = countryCode {
            cityQuery += "," + countryCode
        }
        
        return cityQuery
    }
}

