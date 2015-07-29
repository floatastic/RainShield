//
//  ForecastItem.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation

enum WeatherCode :Int {
    case Rain = 500
    case Snow = 600
}

struct ForecastItem {
    let timestamp: Int?
    let weatherCodeRaw: Int?
    let icon: String?
    
    init(timestamp: Int?, weatherCodeRaw: Int?, icon: String?) {
        self.timestamp = timestamp
        self.weatherCodeRaw = weatherCodeRaw
        self.icon = icon
    }
    
    init(JSONDictionary: NSDictionary) {
        self.timestamp = JSONDictionary[JSONKeys.ForecastItem.timestamp] as? Int
        
        if let weatherArray = JSONDictionary[JSONKeys.ForecastItem.Weather.key] as? [NSDictionary],
            let weatherDictionary = weatherArray.first {
                
                self.weatherCodeRaw = weatherDictionary[JSONKeys.ForecastItem.Weather.id] as? Int
                self.icon = weatherDictionary[JSONKeys.ForecastItem.Weather.icon] as? String
                
        } else {
            
            self.weatherCodeRaw = nil
            self.icon = nil
            
        }
    }
    
    func isWeatherCodeRain() -> Bool {
        return weatherCodeRaw == nil ? false :
            weatherCodeRaw! >= WeatherCode.Rain.rawValue && weatherCodeRaw! < WeatherCode.Snow.rawValue
    }
}
