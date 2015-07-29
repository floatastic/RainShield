//
//  WeatherURLBuilder.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation
import CoreLocation

enum WeatherURLBuilderError: ErrorType {
    case NoLocation
}

class WeatherURLBuilder: NSObject {
    
    private let AppID = "7d03cbb652c57f6fde3fa54083e613d6"
    private let scheme = "http"
    private let host = "api.openweathermap.org"
    private let path = "/data/2.5/forecast/daily"
    private let latitudeParam = "lat"
    private let longitudeParam = "lon"
    private let appParamName = "APPID"
    
    var location: CLLocation?
    
    /**
    Attempting to build() without first setting location will throw WeatherURLBuilderError.NoLocation
    **/
    func build() throws -> NSURL {
        var query = try locationQueryPart()
        query += "&" + appParamName + "=" + AppID
        
        let components = NSURLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.query = query
        
        return components.URL!
    }
    
    func locationQueryPart() throws -> String {
        
        guard let coordinate = location?.coordinate else {
            throw WeatherURLBuilderError.NoLocation
        }
        
        var query = latitudeParam + "=" + String(coordinate.latitude) + "&"
        query += longitudeParam + "=" + String(coordinate.longitude)
        
        return query
    }
}

