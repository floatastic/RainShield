//
//  NetworkManager.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 28.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation
import OHHTTPStubs

class NetworkManager: NSObject {
    
    static let defaultManager = NetworkManager()
    
    override init() {
        super.init()
        
        stubRequestsForTesting()
    }
    
    func addRequest(request: NSURLRequest, completion: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let task = defaultSession().dataTaskWithRequest(request, completionHandler: completion)
        task.resume()
    }
    
    //TODO call in view dealloc or app delegate
    func cancelAllTasks() {
        defaultSession().invalidateAndCancel()
    }
    
}

private extension NetworkManager {
    
    func defaultSession() -> NSURLSession {
        return NSURLSession.sharedSession()
    }
    
    func stubRequestsForTesting() {
        guard NSProcessInfo.processInfo().environment["USE_HTTPSTUBS"] != nil else {
            return
        }
        
        HTTPStubHelper().stubForecastRequest()
    }
}
