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
        
        continueAfterFailure = false
        
        XCUIApplication().launch()

    }
    
    func test_shouldDisplayCellsWithWeatherInformation() {
        let cell = XCUIApplication().tables.childrenMatchingType(.Cell).elementBoundByIndex(0)
        let existPredicate = NSPredicate(format: "exists == 1")
        expectationForPredicate(existPredicate, evaluatedWithObject: cell, handler: nil)
        waitForExpectationsWithTimeout(5.0, handler: nil)
        
        XCTAssert(XCUIApplication().tables.count == 1)
        XCTAssert(XCUIApplication().tables.elementBoundByIndex(0).cells.count == 7)
    }
    
}
