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
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: WeatherPresenter?
    var tableDataSource: WeatherTableDataSource?
    var tableDelegate: WeatherTableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = WeatherPresenter()
        presenter!.delegate = self
        
        cityLabel.text = NSLocalizedString("rainshield.gettingForecastLabel")
        forecastLabel.hidden = true
        
        tableDataSource = WeatherTableDataSource()
        tableDelegate = WeatherTableDelegate()
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
    }
    
    // MARK: WeatherPresenterDelegate
    
    func weatherPresenter(presenter: WeatherPresenter, didUpdateWeatherPresentation weatherPresentation: WeatherPresentation) {
        forecastLabel.hidden = false
        forecastLabel.text = weatherPresentation.forecastInfo
        cityLabel.text = weatherPresentation.cityInfo
        activitySpinner.stopAnimating()
        
        tableDataSource!.forecastItems = weatherPresentation.forecastItems
        tableView.reloadData()
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

