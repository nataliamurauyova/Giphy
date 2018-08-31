//
//  GiphyAppTests.swift
//  GiphyAppTests
//
//  Created by Nataliya Murauyova on 8/21/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import XCTest
@testable import GiphyApp

class GiphyAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func fileManagerSuccess() {
        let fileManager = GiphyFileManager()
        let url = URL(string: "file:///Users/nataliya_murauyova/Library/Developer/CoreSimulator/Devices/11DFF7FB-89CA-4A69-A188-BA9A5B48FB4C/data/Containers/Data/Application/0826FB09-41BA-483C-9ECB-3384B57897CD/Library/Caches/CFNetworkDownload_zOYoO6.tmp")
        let result = fileManager.copy(toCache: url)
        XCTAssertNotEqual(result, url)
    }
    
    func downloadManagerSuccess(){
        let downloader = Downloader()
        let result = downloader.download(fromLink: "https://media1.giphy.com/media/JIX9t2j0ZTN9S/giphy-preview.gif?cid=e1bb72ff5b87c7185652745167009b69", nil)
        XCTAssert(result)
        
    }
    
    func testParserSuccess() {
        let parser = JSON_Parser()
        let array = parser.parseJSON(fromURL: "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC")
        XCTAssertNotEqual(array?.count, 0)
        
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
