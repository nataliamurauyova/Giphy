//
//  ViewModelTests.swift
//  GiphyAppTests
//
//  Created by Nataliya Murauyova on 9/3/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import XCTest
@testable import GiphyApp

class ViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchGifArray_success() {
        let viewModel = GifViewModel()
        let testUrl = "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&offset=0"
        let resultArray = viewModel.getGifArrayFromJSON(fromURL: testUrl)
        
        XCTAssertNotNil(resultArray?[0])

    }
    
    func testFetchGifArray_failure() {
        let viewModel = GifViewModel()
        let testURL = "http://api.giphy.com/v1/gifs/search?q=hjdshldjgldjfgdhljfg&api_key=dc6zaTOxFJmzC&limit=1&offset=0"
        let resultArray = viewModel.getGifArrayFromJSON(fromURL: testURL)
        
        XCTAssertEqual(resultArray?.count, 0)
    }
    
    func testFetchingGifsForTrends_success() {
        let viewModel = GifViewModel()
        let testURL = "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC"
        let expectation = self.expectation(description: "testFetchingGifsForTrends_success")
        
        var results: Data?
        viewModel.fetchGifsForTrends(url: testURL) { (data, destinationUrl) in
            results = data
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNotNil(results)
    }
    

    func testFetchingGifsForTrends_failure() {
        let viewModel = GifViewModel()
        let testURL = "http://api.giphy.com/v1/gifs/search?q=hjdshldjgldjfgdhljfg&api_key=dc6zaTOxFJmzC&limit=1&offset=0"
        
        viewModel.fetchGifsForTrends(url: testURL) { (data, destinationURL) in
            XCTAssertNil(destinationURL)
        }
    }
    
}
