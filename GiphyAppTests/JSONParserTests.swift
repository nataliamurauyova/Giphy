//
//  JSONParserTests.swift
//  GiphyAppTests
//
//  Created by Nataliya Murauyova on 9/3/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import XCTest
@testable import GiphyApp

class JSONParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParse_success() {
        let parser = JSON_Parser()
        let array = parser.parseJSON(fromURL: "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC")
        
        XCTAssertNotEqual(array?.count, 0)
    }
    
    func testParse_failure() {
        let parser = JSON_Parser()
        let array = parser.parseJSON(fromURL: "https://www.tut.by/?crnd=40939")
        
        XCTAssertNil(array?.count)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
