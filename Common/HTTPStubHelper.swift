//
//  HTTPStubHelper.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation
import OHHTTPStubs

class HTTPStubHelper: NSObject {
    
    func stubForecastRequest() {
        OHHTTPStubs.stubRequestsPassingTest({$0.URL!.host == "api.openweathermap.org"}) { _ in
            let fixture = OHPathForFile("WeatherForecastResponse.json", self.dynamicType)
            return OHHTTPStubsResponse(fileAtPath: fixture!,
                statusCode: 200, headers: ["Content-Type":"application/json"])
        }
    }
    
    class func removeAllStubs() {
        OHHTTPStubs.removeAllStubs()
    }
}
