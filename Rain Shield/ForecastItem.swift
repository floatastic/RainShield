//
//  ForecastItem.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation

struct ForecastItem {
    let timestamp: Int?
    let id: Int?
    let icon: String?
    
    init(JSONDictionary: NSDictionary) {
        self.timestamp = JSONDictionary[JSONKeys.ForecastItem.timestamp] as? Int
        
        if let weatherArray = JSONDictionary[JSONKeys.ForecastItem.Weather.key] as? [NSDictionary],
            let weatherDictionary = weatherArray.first {
                
                self.id = weatherDictionary[JSONKeys.ForecastItem.Weather.id] as? Int
                self.icon = weatherDictionary[JSONKeys.ForecastItem.Weather.icon] as? String
                
        } else {
            
            self.id = nil
            self.icon = nil
            
        }
    }
}