//
//  DownloaderTests.swift
//  GiphyAppTests
//
//  Created by Nataliya Murauyova on 9/3/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import XCTest

@testable import GiphyApp

class DownloaderTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDownloaderFunctionData_success() {
        let downloader = Downloader()
        let gifUrl = "https://media1.giphy.com/media/XHHRbQZOsFmVQe9Om2/giphy-preview.gif?cid=e1bb72ff5b8ce93132684241638e1516"
        downloader.fetchGif(withUrlAndError: gifUrl) { (data, destinationUrl, error) in
            XCTAssertNotNil(data)
        }
       
    }
    
    func testDownloaderFunctionData_failure() {
        let downloader = Downloader()
        let gifUrl = " "
        downloader.fetchGif(withUrlAndError: gifUrl) { (data, url, error) in
            XCTAssertNil(data)
        }
    }
    
    func testDownloaderFunctionError_success() {
        let downloader = Downloader()
        let gifUrl = "https://media1.giphy.com/media/XHHRbQZOsFmVQe9Om2/giphy-preview.gif?cid=e1bb72ff5b8ce93132684241638e1516"
        downloader.fetchGif(withUrlAndError: gifUrl) { (data, destinationURL, error) in
            XCTAssertNotNil(error)
        }
    }
    
    func testDownloaderFunctionDataUsingExpectations_success(){
        let downloader = Downloader()
        let gifUrl = "https://media1.giphy.com/media/XHHRbQZOsFmVQe9Om2/giphy-preview.gif?cid=e1bb72ff5b8ce93132684241638e1516"
        let expectation = self.expectation(description: "testDownloaderFunctionDataUsingExpectations_success")
        
        var result: Data?
        
        downloader.fetchGif(withUrlAndError: gifUrl) { (data, destinationUrl, error) in
            result = data
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertNotNil(result)
    }
    

    
}
