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
    let description: String?
    let tempDay: Double?
    let tempNight: Double?
    
    init(timestamp: Int?, weatherCodeRaw: Int?, icon: String?, description: String? = nil,
        tempDay: Double? = nil, tempNight: Double? = nil) {
            
        self.timestamp = timestamp
        self.weatherCodeRaw = weatherCodeRaw
        self.icon = icon
        self.description = description
        self.tempDay = tempDay
        self.tempNight = tempNight
    }
    
    init(JSONDictionary: NSDictionary) {
        timestamp = JSONDictionary[JSONKeys.ForecastItem.timestamp] as? Int
        
        if let weatherArray = JSONDictionary[JSONKeys.ForecastItem.Weather.key] as? [NSDictionary],
            weatherDictionary = weatherArray.first,
            temperatureDictionary = JSONDictionary[JSONKeys.ForecastItem.Temperature.key] as? NSDictionary
            {
                weatherCodeRaw = weatherDictionary[JSONKeys.ForecastItem.Weather.id] as? Int
                icon = weatherDictionary[JSONKeys.ForecastItem.Weather.icon] as? String
                description = weatherDictionary[JSONKeys.ForecastItem.Weather.main] as? String
                tempDay = temperatureDictionary[JSONKeys.ForecastItem.Temperature.day] as? Double
                tempNight = temperatureDictionary[JSONKeys.ForecastItem.Temperature.night] as? Double
                
        } else {
            weatherCodeRaw = nil
            icon = nil
            description = nil
            tempDay = nil
            tempNight = nil
        }
    }
    
    func isWeatherCodeRain() -> Bool {
        return weatherCodeRaw == nil ? false :
            weatherCodeRaw! >= WeatherCode.Rain.rawValue && weatherCodeRaw! < WeatherCode.Snow.rawValue
    }
}
