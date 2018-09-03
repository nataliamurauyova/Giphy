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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
