//
//  ViewController.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 27.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherPresenterDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var forecastLabel: UILabel!
    
    var presenter: WeatherPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = WeatherPresenter()
        presenter!.delegate = self
        
        cityLabel.text = NSLocalizedString("rainshield.gettingForecastLabel")
        forecastLabel.hidden = true
    }
    
    // MARK: WeatherPresenterDelegate
    
    func weatherPresenter(presenter: WeatherPresenter, didUpdateWeatherPresentation weatherPresentation: WeatherPresentation) {
        self.forecastLabel.hidden = false
        self.forecastLabel.text = weatherPresentation.forecastInfo
        self.cityLabel.text = weatherPresentation.cityInfo
        self.activitySpinner.stopAnimating()
    }

    func weatherPresenterDidFailWithNoLocationAccess(presenter: WeatherPresenter) {
        noLocalizationAccessAlert().show()
    }
    
    func noLocalizationAccessAlert() -> UIAlertView {
        return UIAlertView(title: NSLocalizedString("rainshield.noLocaliztionAccessError.title"),
            message: NSLocalizedString("rainshield.noLocaliztionAccessError.message"),
            delegate: nil,
            cancelButtonTitle: NSLocalizedString("rainshield.noLocaliztionAccessError.button")
        )
    }
}

