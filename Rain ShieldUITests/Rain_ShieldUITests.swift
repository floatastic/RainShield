//
//  Rain_ShieldUITests.swift
//  Rain ShieldUITests
//
//  Created by Kreft, Michal on 27.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import XCTest

class Rain_ShieldUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchArguments = ["USE_HTTPSTUBS"]
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let label = XCUIApplication().tables.staticTexts["forecast"]
        let existPredicate = NSPredicate(format: "exists == 1")
        expectationForPredicate(existPredicate, evaluatedWithObject: label, handler: nil)
        waitForExpectationsWithTimeout(5.0, handler: nil)
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
