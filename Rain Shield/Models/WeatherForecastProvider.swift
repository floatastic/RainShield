//
//  WeatherProvider.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation
import CoreLocation

enum WeatherForecastErrorCode: Int {
    case InvalidResponse
}

class WeatherForecastProvider: NSObject {
    
    let networkManager: NetworkManager
    
    class func defaultProvider() -> WeatherForecastProvider {
        return WeatherForecastProvider(networkManager: NetworkManager.defaultManager)
    }
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init()
    }

    func weatherForLocation(location: CLLocation, completion: (WeatherForecast?, NSError?) -> Void ) {
        
        let request = weatherRequest(location)
        networkManager.addRequest(request, completion: { (data, response, error) -> Void in
            
            if let data = data,
                let weatherForecast = WeatherForecast(JSONData: data) {
                    
                completion(weatherForecast, nil)
                    
            } else {
                completion(nil, self.errorWithCode(.InvalidResponse))
            }
            
        })
        
    }

    
}

private extension WeatherForecastProvider {
    
    func weatherRequest(location: CLLocation) -> NSURLRequest {
        let URLBuilder = WeatherURLBuilder()
        URLBuilder.location = location
        
        let URL = try! URLBuilder.build()
        
        return NSURLRequest(URL: URL)
    }
    
    func errorWithCode(code: WeatherForecastErrorCode) -> NSError {
        return NSError(domain: DefaultErrorDomain, code: code.rawValue, userInfo: nil)
    }
}
