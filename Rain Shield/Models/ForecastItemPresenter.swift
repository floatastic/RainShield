//
//  ForecastItemPresenter.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation

class ForecastItemPresenter: NSObject {
    
    static var dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    var forecastItem: ForecastItem?
    
    func weekDay() -> String? {
        guard let timestamp = forecastItem?.timestamp else {
            return nil
        }
        
        let date = NSDate(timeIntervalSince1970: Double(timestamp))
        return self.dynamicType.dateFormatter.stringFromDate(date)
    }
    
    func weatherDescription() -> String? {
        guard let description = forecastItem?.description else {
            return nil
        }
        
        return NSLocalizedString(description)
    }
    
    func dayTemperature() -> String? {
        guard let temperature = forecastItem?.tempDay else {
            return nil
        }
        
        return formattedTemperature(degrees: temperature)
    }
    
    func nightTemperature() -> String? {
        guard let temperature = forecastItem?.tempNight else {
            return nil
        }
        
        return formattedTemperature(degrees: temperature)
    }
    
}

private extension ForecastItemPresenter {
    
    func formattedTemperature(degrees degrees: Double) -> String {
        return String(format: NSLocalizedString("rainshield.temperatureFormat")!, degrees)
    }
    
}
