//
//  Weather.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation

struct WeatherForecast {
    
    let city: City?
    let items: [ForecastItem]
    
    init(city: City?, items: [ForecastItem] = [ForecastItem]()) {
        self.city = city
        self.items = items
    }
    
    init?(JSONData: NSData) {
        do {
            if let JSONDictionary = try NSJSONSerialization.JSONObjectWithData(JSONData, options: .MutableContainers) as? NSDictionary {
                city = JSONTransformer.cityFromJSONDictionary(JSONDictionary)
                items = JSONTransformer.forecastItemsFromJSONDictionary(JSONDictionary)
            } else {
                return nil
            }
        } catch {
            return nil
        }
        
    }
    
}

class JSONTransformer {
    
    class func cityFromJSONDictionary(JSONDictionary: NSDictionary) -> City? {
        var city: City? = nil
        
        if let cityDictionary = JSONDictionary[JSONKeys.City.key] as? NSDictionary {
            city = City(JSONDictionary: cityDictionary)
        }
        
        return city
    }
    
    class func forecastItemsFromJSONDictionary(JSONDictionary: NSDictionary) -> [ForecastItem] {
        var items = [ForecastItem]()
        
        if let list = JSONDictionary[JSONKeys.list] as? [NSDictionary] {
            for itemDictionary in list  {
                items.append(ForecastItem(JSONDictionary: itemDictionary))
            }
        }
        
        return items
    }
    
}
