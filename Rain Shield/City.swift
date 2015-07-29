//
//  City.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation

struct City {
    let name: String?
    
    init(JSONDictionary: NSDictionary) {
        self.name = JSONDictionary[JSONKeys.City.name] as? String
    }
}