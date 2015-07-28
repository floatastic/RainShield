//
//  PlacemarkMock.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import UIKit
import CoreLocation

class PlacemarkMock: CLPlacemark {
    
    override var name: String? {
        get {
            return "London"
        }
    }
    
}
