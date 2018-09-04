//
//  DateFormatTests.swift
//  GiphyAppTests
//
//  Created by Nataliya Murauyova on 9/3/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import XCTest
@testable import GiphyApp

class DateFormatTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testDateFormatter_success() {
    let inputDate = "2016-08-12 12:29:09"
    let formattedString = String.convertDateFrom(date: inputDate)
    let testResult = "Aug 12,2016"
    XCTAssertEqual(formattedString, testResult)
    }
    
    func testDateFormatter_failure() {
        let inputDate = "2016-08-12 12:29:09"
        let formattedString = String.convertDateFrom(date: inputDate)
        let testResult = "Jan 12,2018"
        XCTAssertNotEqual(formattedString, testResult)
    }
    
    
}
