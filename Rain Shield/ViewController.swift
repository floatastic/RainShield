//
//  ViewController.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 27.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, LocationProviderDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    
    var locationProvider: LocationProvider?
    var forecastProvider: WeatherForecastProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationProvider()
        forecastProvider = WeatherForecastProvider.defaultProvider()
        
        cityLabel.text = NSLocalizedString("rainshield.gettingLocationLabel")
        forecastLabel.hidden = true
    }
    
    func setupLocationProvider() {
        let provider = LocationProvider.defaultProvider()
        provider.delegate = self
        provider.updateLocation()
        locationProvider = provider
    }
    
    deinit {
        locationProvider?.stopMonitoring()
    }

    // MARK: LocationProviderDelegate
    
    func locationProvider(locationProvider: LocationProvider, didUpdateLocation location: CLLocation) {
        cityLabel.text = NSLocalizedString("rainshield.gettingForecastLabel")
        
        forecastProvider!.weatherForLocation(location) { (forecast, error) -> Void in
            var forecastLabelText: String?
            var cityLabelText: String?
            
            if let forecast = forecast {
                forecastLabelText = self.statusLabelTextForWeatherForecast(forecast)
            } else {
                forecastLabelText = NSLocalizedString("rainshield.unableToGetForecastLabel")
            }
            
            if let cityName = forecast?.city?.name {
                cityLabelText = String(format: NSLocalizedString("rainshield.cityInfoLabel")!, cityName)
            } else {
                cityLabelText = NSLocalizedString("rainshield.unableToGetLocationLabel")
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                self.forecastLabel.hidden = false
                self.forecastLabel.text = forecastLabelText
                self.cityLabel.text = cityLabelText
            }
        }
    }
    
    func locationProvider(locationProvider: LocationProvider, failedToUpdateWithError error: NSError) {
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            
            if error.code == LocationProviderErrorCode.NoAuthorization.rawValue {
                self.noLocalizationAccessAlert().show()
            }
        
            self.cityLabel.text = NSLocalizedString("rainshield.unableToGetLocationLabel")
        }
    }
    
    func statusLabelTextForWeatherForecast(forecast: WeatherForecast) -> String? {
        return Prophet(forecast: forecast).isTodayRainy() ?
            NSLocalizedString("rainshield.itWillRainLabel") : NSLocalizedString("rainshield.itWillNotRainLabel")
    }
    
    func noLocalizationAccessAlert() -> UIAlertView {
        return UIAlertView(title: NSLocalizedString("rainshield.noLocaliztionAccessError.title"),
            message: NSLocalizedString("rainshield.noLocaliztionAccessError.message"),
            delegate: nil,
            cancelButtonTitle: NSLocalizedString("rainshield.noLocaliztionAccessError.button")
        )
    }
}

