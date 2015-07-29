//
//  WeatherTableDataSource.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import UIKit
import Foundation

class WeatherTableDataSource: NSObject, UITableViewDataSource {
    
    var forecastItems = [ForecastItem]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as! WeatherCell

        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return forecastItems.count > 0 ? NSLocalizedString("rainshield.weatherTableSectionHeader") : nil
    }
}
