//
//  Prophet.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation

/**
Prophet processes WeahterForecast in order to tell if it will rain for the current day.
Simply init it with current forecast and call isTodayRainy() to get an answer.
**/
class Prophet: NSObject {
    
    let forecast: WeatherForecast
    
    init(forecast: WeatherForecast) {
        self.forecast = forecast
        super.init()
    }
    
    func isTodayRainy() -> Bool {
        return forecastItemsForToday().filter({ $0.isWeatherCodeRain() }).count > 0
    }
    
    func forecastItemsForToday() -> [ForecastItem] {
        let endOfDayTimestamp = Int(DateHelper.endOfDay())
        return forecast.items.filter({ $0.timestamp < endOfDayTimestamp })
    }
    
}
