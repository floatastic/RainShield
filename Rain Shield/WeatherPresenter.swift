//
//  WeatherPresenter.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherPresentation {
    let cityInfo: String?
    let forecastInfo: String?
}

/**
WeatherPresenterDelegate always calls it's delegate on main thread
**/
protocol WeatherPresenterDelegate: class {
    func weatherPresenter(presenter: WeatherPresenter, didUpdateWeatherPresentation weatherPresentation: WeatherPresentation)
    
    /**
    Special case for this error, because it may require specific behaviour, i.e. displaying an alert
    **/
    func weatherPresenterDidFailWithNoLocationAccess(presenter: WeatherPresenter)
}

class WeatherPresenter: NSObject, LocationProviderDelegate {

    var locationProvider: LocationProvider?
    var forecastProvider: WeatherForecastProvider?
    weak var delegate: WeatherPresenterDelegate?

    override init() {
        forecastProvider = WeatherForecastProvider.defaultProvider()
        
        super.init()
        setupLocationProvider()
    }

    func setupLocationProvider() {
        let provider = LocationProvider.defaultProvider()
        provider.delegate = self
        provider.updateLocation()
        locationProvider = provider
    }
    
    // MARK: LocationProviderDelegate
    
    func locationProvider(locationProvider: LocationProvider, didUpdateLocation location: CLLocation) {
        forecastProvider!.weatherForLocation(location) { (forecast, error) -> Void in
            var forecastInfo: String?
            var cityInfo: String?
            
            if let forecast = forecast {
                forecastInfo = self.statusLabelTextForWeatherForecast(forecast)
            } else {
                forecastInfo = NSLocalizedString("rainshield.unableToGetForecastLabel")
            }
            
            if let cityName = forecast?.city?.name {
                cityInfo = String(format: NSLocalizedString("rainshield.cityInfoLabel")!, cityName)
            } else {
                cityInfo = NSLocalizedString("rainshield.unableToGetLocationLabel")
            }
            
            let presentation = WeatherPresentation(cityInfo: cityInfo, forecastInfo: forecastInfo)
            
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                self.delegate?.weatherPresenter(self, didUpdateWeatherPresentation: presentation)
            }
        }
    }
    
    func locationProvider(locationProvider: LocationProvider, failedToUpdateWithError error: NSError) {
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            
            if error.code == LocationProviderErrorCode.NoAuthorization.rawValue {
                self.delegate?.weatherPresenterDidFailWithNoLocationAccess(self)
            }

            let presentation = WeatherPresentation(cityInfo: NSLocalizedString("rainshield.unableToGetLocationLabel"), forecastInfo: nil)
            self.delegate?.weatherPresenter(self, didUpdateWeatherPresentation: presentation)
            
        }
    }
    
    func statusLabelTextForWeatherForecast(forecast: WeatherForecast) -> String? {
        return Prophet(forecast: forecast).isTodayRainy() ?
            NSLocalizedString("rainshield.itWillRainLabel") : NSLocalizedString("rainshield.itWillNotRainLabel")
    }
    
    deinit {
        locationProvider?.stopMonitoring()
    }
}
