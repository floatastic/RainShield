//
//  WeatherTableDataSource.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import UIKit
import Foundation

class WeatherTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var forecastItems = [ForecastItem]()
    private lazy var itemPresenter = {
        ForecastItemPresenter()
    }()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as! WeatherCell
        
        itemPresenter.forecastItem = forecastItems[indexPath.row]
        cell.dayLabel.text = itemPresenter.weekDay()
        cell.weatherLabel.text = itemPresenter.weatherDescription()
        cell.tempDayLabel.text = itemPresenter.dayTemperature()
        cell.tempNightLabel.text = itemPresenter.nightTemperature()

        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return forecastItems.count > 0 ? NSLocalizedString("rainshield.weatherTableSectionHeader") : nil
    }
}
