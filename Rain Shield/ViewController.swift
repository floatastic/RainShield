//
//  ViewController.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 27.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LocationProviderDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    
    var locationProvider: LocationProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationProvider()
        
        cityLabel.text = NSLocalizedString("rainshield.gettingLocationLabel")
    }
    
    func setupLocationProvider() {
        let provider = LocationProvider.defaultProvider()
        provider.delegate = self
        provider.updateLocation()
        locationProvider = provider
    }

    // MARK: LocationProviderDelegate
    
    func locationProvider(locationProvider: LocationProvider, didUpdateCity city: City) {
        cityLabel.text = city.name
    }
    
    func locationProvider(locationProvider: LocationProvider, failedToUpdateWithError error: NSError) {
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            
            if error.code == LocationProviderErrorCode.NoAuthorization.rawValue {
                
                UIAlertView(title: NSLocalizedString("rainshield.noLocaliztionAccessError.title"),
                    message: NSLocalizedString("rainshield.noLocaliztionAccessError.message"),
                    delegate: nil,
                    cancelButtonTitle: NSLocalizedString("rainshield.noLocaliztionAccessError.button")
                    ).show()
            }
        
            self.cityLabel.text = NSLocalizedString("rainshield.unableToGetLocationLabel")
        }
    }
    
    deinit {
        locationProvider?.stopMonitoring()
    }
}

