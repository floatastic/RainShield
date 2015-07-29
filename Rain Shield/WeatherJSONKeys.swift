//
//  WeatherJSONKeys.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

struct JSONKeys {
    
    static let list = "list"
    
    struct City {
        static let key = "city"
        static let name = "name"
    }
    
    struct ForecastItem {
        static let timestamp = "dt"
        
        struct Weather {
            static let key = "weather"
            static let main = "main"
            static let id = "id"
            static let icon = "icon"
        }
        
        struct Temperature {
            static let key = "temp"
            static let day = "day"
            static let night = "night"
        }
    }
}